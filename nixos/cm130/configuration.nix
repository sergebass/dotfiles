# NixOS configuration for my AMD x64 workstation in CoolerMaster-130 case

{ config, lib, pkgs, ... }:
let
  userName = "sergii";
  userId = 1000;

  useDM = false;

in {
  imports = [
    ./hardware-configuration.nix  # Results of the hardware scan. To redo detection: nixos-generate-config
    ../common-configuration.nix  # Common configuration shared by all of our NixOS systems
  ];

  boot = {
    loader = {
      # Since we reuse existing partitioning from the old laptop, keep the GRUB/MBR setting for now.
      grub = {
        enable = true;
        device = "/dev/sda";
      };
    };

    kernelParams = lib.mkForce [
      "verbose"
      "nosplash"

      # To enable APU/GPU acceleration for AMD "Kaveri" processors we need to be explicit:
      # (https://en.wikipedia.org/wiki/Graphics_Core_Next#Graphics_Core_Next_2)
      # For Sea Islands (CIK i.e. GCN 2) cards
      "radeon.cik_support=0"
      "amdgpu.cik_support=1"
    ];

    kernel.sysctl = {
      # "net.ipv4.ip_forward" = 1;  # Enable IP packet forwarding for Waydroid containers
    };

    tmp.useTmpfs = true;  # Save SSD from some wear and tear

    supportedFilesystems = [
      "btrfs"
      "zfs"
      "exfat"
      "ntfs"
      "ntfs3"
    ];

    zfs = {
      forceImportRoot = false;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk  # AMD/Vulkan support
        rocmPackages.clr.icd  # AMD Common Language Runtime for hipamd, opencl, and rocclr
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };

    # Uncomment to connect to an explicit printer
    # printers = let
    #   printerHost = "192.168.111.3";
    # in {
    #   ensurePrinters = [
    #     {
    #       name = "Brother-DCP-7060D";
    #       description = "Laser monochrome printer & scanner";
    #       location = "Basement";
    #       deviceUri = "http://${printerHost}:631/printers/DCP-7060D";
    #       model = "drv:///brlaser.drv/br7060d.ppd";
    #       ppdOptions = {
    #         PageSize = "Letter";
    #       };
    #     }
    #   ];
    #   ensureDefaultPrinter = "Brother-DCP-7060D";
    # };

    # Scanner support
    sane = {
      enable = true;
      brscan4.enable = true;  # Brother DCP-7060D scanner
    };

    rtl-sdr.enable = true;  # For external Software Defined Radio dongles

    firmware = with pkgs; [
      libreelec-dvb-firmware  # DVB firmware from LibreELEC (for many TV tuner devices)
    ];
  };

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
  };

  networking = {
    hostName = "cm130";

    # The primary use case is to ensure when using ZFS that a pool isn’t imported accidentally on a wrong machine.
    hostId = "b5481747";  # Result of running: head -c 8 /etc/machine-id

    firewall = {
      enable = true;
      # allowedTCPPorts = [
      #   631  # CUPS
      # ];
      # allowedUDPPorts = [
      #   631  # CUPS
      # ];
    };
  };

  services = {
    udev = {
      enable = true;

      packages = with pkgs; [
        openhantek6022  # Make sure we can access our USB oscilloscope properly
        rtl-sdr  # For Nooelec Software Defined Radio dongle
      ];

      # A rule to allow ACPI backlight control by a non-root user from video group
      extraRules = with pkgs; ''
        ACTION=="add", SUBSYSTEM=="backlight", RUN+="${coreutils}/bin/chgrp video $sys$devpath/brightness", RUN+="${coreutils}/bin/chmod g+w $sys$devpath/brightness"
      '';
    };

    libinput.enable = true;  # Enable touchpad support

    gvfs.enable = true;  # Mount, trash, and other functionalities

    xserver = {
      enable = true;

      videoDrivers = [ "amdgpu" ];

      displayManager = {
        startx.enable = ! useDM;

        lightdm = {
          enable = useDM;
          greeter.enable = true;
          background = /home/${userName}/.background-image;
        };
      };

      desktopManager = {
        xterm.enable = false;
        wallpaper = {
          mode = "max";
          combineScreens = false;
        };
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock
        ];
      };

      xkb = {
        layout = "us(altgr-intl),ua";
        options = "grp:shift_caps_toggle,grp:shifts_toggle,grp_led:scroll,caps:escape,compose:rctrl-altgr,terminate:ctrl_alt_bksp";
      };
    };

    blueman.enable = true;

    system-config-printer.enable = true;

    printing = {
      enable = true;  # Enable CUPS
      startWhenNeeded = true;  # Enable printing on-demand only
      webInterface = true;  # Enable CUPS web UI as well
      browsing = true;  # Advertise local printers on our LAN
      browsed.enable = false;  # But do not browse for external printers (https://www.evilsocket.net/2024/09/26/Attacking-UNIX-systems-via-CUPS-Part-I/)
      listenAddresses = [
        "*:631"
      ];
      allowFrom = [
        "all"
      ];
      openFirewall = true;  # Open ports for listenAddresses
      defaultShared = true;  # Local printers are shared by default.
      cups-pdf.enable = true;  # Enable the virtual PDF printer backend
      drivers = with pkgs; [
        brlaser  # For Brother DCP-7060D (and others)
      ];
    };

    # Enable auto-discovery (of local printers in particular)
    avahi = {
      enable = true;
      openFirewall = true;  # Discovery is done via the opened UDP port 5353
      nssmdns4 = true;  # Enable the mDNS NSS (Name Service Switch) plug-in for IPv4. Enabling it allows applications to resolve names in the .local domain by transparently querying the Avahi daemon.
      nssmdns6 = true;  # Same for IPv6
      publish = {
        enable = true;
        userServices = true;
      };
    };

    # Music Player Daemon
    mpd = {
      enable = true;
      startWhenNeeded = true;  # systemd feature: only start MPD service upon connection to its socket

      user = userName;  # Do not run as root

      network = {
        listenAddress = "any";  # Allow non-localhost connections
        port = 6600;  # port 6600 is the default
      };

      musicDirectory = "/home/${userName}/music";
      playlistDirectory = "/home/${userName}/music/playlists";

      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire"
        }

        audio_output {
          type "pulse"
          name "PulseAudio"
          # server "remote_server" # optional
          # sink "remote_server_sink" # optional
        }

        # Audio output for use on Linux
        audio_output {
          type "alsa"
          name "ALSA (default)"
          # device "hw:0,0" # optional
          # format "44100:16:2" # optional
          # mixer_type "hardware" # optional
          # mixer_device "default" # optional
          # mixer_control "PCM" # optional
          # mixer_index "0" # optional
        }
      '';
    };
  };

  xdg.portal = {
    enable = true;  # Enable xdg desktop integration (https://github.com/flatpak/xdg-desktop-portal).
    xdgOpenUsePortal = false;  # Do not use portal to open programs or web links using xdg-open
    wlr.enable = true;  # Enable desktop portal for wlroots-based desktops.
    lxqt.enable = true;  # Enable the desktop portal for the LXQt desktop environment.

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk  # Desktop integration portals for sandboxed apps
      xdg-desktop-portal-xapp  # Backend implementation for xdg-desktop-portal for Cinnamon, MATE, Xfce
    ];
  };

  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString userId}"; # MPD will look inside this directory for the PipeWire socket.
  };

  # Run LineageOS-based Android VM in a container (https://docs.waydro.id)
  #
  # To download an actual current Android image for the current platform:
  # (remove "-s GAPPS" if you do not need Google apps)
  #   sudo waydroid init -s GAPPS -f
  #
  # To start a session (headless), run:
  #   waydroid session start
  #
  # Once the session is started, invoke full Android UI with:
  #   waydroid show-full-ui
  #
  # If Google apps (GAPPS) are installed, follow the steps at
  # https://docs.waydro.id/faq/google-play-certification
  # to enable Google Play services.
  #
  # See also https://wiki.nixos.org/wiki/Waydroid
  virtualisation.waydroid.enable = true;

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      adbfs-rootless  # Mount Android phones on Linux with adb, no root required
      alacritty
      android-studio
      android-studio-tools
      android-tools  # Android SDK platform tools
      ardour
      arduino-cli  # Arduino from the command line
      arduino-ide  # Open-source electronics prototyping platform
      arduino-language-server  # Arduino Language Server based on Clangd to Arduino code autocompletion
      asciidoctor  # A faster Asciidoc processor written in Ruby
      audacity
      baobab  # Used disk space visualizer
      bash-language-server  # A language server for Bash
      brave
      btrfs-heatmap
      btrfs-progs
      btrfs-snap
      calibre
      calibre-web
      cargo  # Downloads your Rust project's dependencies and builds your project
      ccache  # C++ compiler cache
      cheese  # Take photos and videos with your webcam, with fun graphical effects
      chromium
      clang-tools  # Standalone command line tools for C++ development (clangd, clang-format etc.)
      cmake
      cmake-language-server  # CMake LSP Implementation
      coltrane
      compsize  # Compression ratio calculator for btrfs
      darktable  # Virtual lighttable and darkroom for photographers
      denemo
      dmenu
      dunst
      exiftool  # A tool to read, write and edit EXIF meta information
      fbmark  # Linux framebuffer benchmarking tool
      feh
      ffmpeg
      firefox
      freetube
      frescobaldi
      fuzzel
      gcc13
      gdb  # GNU debugger
      geekbench  # CPU benchmarking tool
      geeqie
      glmark2  # OpenGL benchmarking tool (with Wayland support)
      glxinfo  # Display OpenGL information (glxinfo and eglinfo)
      gnome-maps
      gnumake
      gnuradio
      gparted
      gqrx
      guitarix
      gxplugins-lv2
      haskell-language-server  # LSP server for GHC
      hydrogen
      jack2.dev  # JACK audio connection kit, version 2 with jackdbus
      jackmeter
      jdk  # The open-source Java Development Kit
      kotlin-language-server  # kotlin language server
      libdrm  # Direct Rendering library and test utilities (e.g. modetest)
      libnotify
      libreoffice
      light # Control backlight brightness
      lilypond-with-fonts
      lldb  # LLVM debugger
      llvmPackages.clangUseLLVM  # C language family frontend for LLVM (wrapper script)
      lua-language-server  # Language server that offers Lua language support
      luajit
      marble
      meld  # Visual diff and merge tool
      meterbridge  # Various meters (VU, PPM, DPM, JF, SCO) for Jack Audio Connection Kit
      mi2ly
      mpc_cli
      mpd
      mpv
      mupdf
      musescore
      ncmpcpp
      networkmanagerapplet  # Provides nm-connection-editor
      nodePackages.purescript-language-server  # Language Server Protocol server for PureScript wrapping purs ide server functionality
      nodejs_22  # Node.JS and NPM
      nufraw  # Utility to read and manipulate raw images from digital cameras
      nushell  # Modern shell written in Rust
      open-in-mpv  # Simple web extension to open videos in mpv
      openhantek6022  # Free software for Hantek and compatible (Voltcraft/Darkwire/Protek/Acetech) USB digital signal oscilloscopes
      pandoc  # Converter between documentation formats
      pavucontrol
      pkg-config  # A tool that allows packages to find out information about other packages (wrapper script)
      pwvucontrol  # Pipewire Volume Control
      qjackctl
      qpwgraph
      qrencode
      qsynth
      rakarrack
      rofi
      rofi-bluetooth
      rofi-calc
      rofi-file-browser
      rofi-mpd
      rofi-pulse-select
      rofi-systemd
      rofi-top
      rtl-sdr
      rust-analyzer  # A modular compiler frontend for the Rust language
      rust-bindgen  # Automatically generates Rust FFI bindings to C (and some C++) libraries
      rustc  # Rust compiler
      rustfmt  # Tool for formatting Rust code according to style guidelines
      scrot
      signal-cli
      signal-desktop
      simple-scan  # Simple paper scanning GUI app
      sound-theme-freedesktop  # Freedesktop reference sounds
      sox
      sway-launcher-desktop  # Note that this tool is not really tied to sway at all
      system-config-printer  # Printer configuration/pipeline control UI
      thunderbird
      tuxguitar
      typescript
      typescript-language-server  # Language Server Protocol implementation for TypeScript using tsserver (https://github.com/typescript-language-server/typescript-language-server)
      vim-language-server  # VImScript language server, LSP for vim script
      vkmark  # Vulkan benchmarking suite
      vlc
      vulkan-tools  # Khronos official Vulkan Tools and Utilities
      w_scan2  # A small channel scan tool which generates ATSC, DVB-C, DVB-S/S2 and DVB-T/T2 channels.conf files. Use: w_scan2 -fa -c CA > channels.conf
      wayland-utils  # Wayland utilities (wayland-info)
      wev  # Wayland event tester (similar to xev for X11)
      xdg-dbus-proxy  # DBus proxy for Flatpak and others
      xdg-launch  # A command line XDG compliant launcher and tools
      xdg-terminal-exec  # Reference implementation of the proposed XDG Default Terminal Execution Specification
      xdg-user-dirs  # A tool to help manage well known user directories like the desktop folder and the music folder
      xdg-utils  # A set of command line tools that assist applications with a variety of desktop integration tasks
      xorg.xkill
      xorg.xrandr
      xorg.xsetroot
      yaml-language-server  # Language Server for YAML Files
      yewtube
      ymuse  # GUI client for MPD
      youtube-music
      zfs
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];

    variables = {
      # We need this to be able to build some 3rd party packages ignoring the NixOS way temporarily
      # (e.g. for building Rust package dependencies before they can be Nixified properly)
      PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
    };
  };

  programs = {
    # Sway is a Wayland compositor
    sway = {
      enable = true;
      extraPackages= with pkgs; [
        grim
        mako  # Pop-up notifications
        rofi-wayland
        slurp
        swaybg
        swayfx
        swayidle
        swayimg
        swaylock
        wl-clipboard
      ];
      extraOptions = [
        "--verbose"
      ];
      extraSessionCommands = ''
        # Some apps need explicit hints to choose Wayland over X11
        export GDK_BACKEND=wayland
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export NIXOS_OZONE_WL=1
        export ELECTRON_OZONE_PLATFORM_HINT=wayland
        export MOZ_ENABLE_WAYLAND=1
      '';
      wrapperFeatures.gtk = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
