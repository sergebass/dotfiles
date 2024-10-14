# NixOS configuration for my AMD x64 workstation in CoolerMaster-130 case

{ config, lib, pkgs, ... }:
let
  userName = "sergii";
  userId = 1000;

  aliases = {
    v = "$VISUAL";
    g = "git";
    rg = "rg -L --sort path --no-heading -n --column";
    x11 = "startx (which i3)";
  };

  useDM = false;

in {
  imports = [
    # Include the results of the hardware scan.
    # To redo hardware detection: nixos-generate-config
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
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
      "kernel.sysrq" = 1;  # Enable all SysRq functions
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

    pulseaudio.enable = false;  # Use PipeWire instead

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
    };

    rtl-sdr.enable = true;  # For external Software Defined Radio dongles
  };

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
  };

  security = {
    rtkit.enable = true;

    sudo = {
      enable = true;

      # Do not require password for rebooting or powering the device off
      extraRules = [{
        commands = [
          {
            command = "${pkgs.systemd}/bin/reboot";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${pkgs.systemd}/bin/poweroff";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }];
    };
  };

  networking = {
    hostName = "cm130";

    # The primary use case is to ensure when using ZFS that a pool isn’t imported accidentally on a wrong machine.
    hostId = "b5481747";  # Result of running: head -c 8 /etc/machine-id

    networkmanager = {
      enable = true;

      # Prefer our own DNS server list
      insertNameservers = [
        "9.9.9.9"  # Quad9 DNS resolver (https://en.wikipedia.org/wiki/Quad9)
        "8.8.8.8"  # Google Public DNS (https://en.wikipedia.org/wiki/Google_Public_DNS)
        "8.8.4.4"  # Google Public DNS (https://en.wikipedia.org/wiki/Google_Public_DNS)
        "1.1.1.1"  # CloudFlare DNS (https://en.wikipedia.org/wiki/1.1.1.1)
        "1.0.0.1"  # CloudFlare DNS (https://en.wikipedia.org/wiki/1.1.1.1)
      ];

      wifi.powersave = true;
    };
  };

  time.timeZone = "Canada/Eastern";

  i18n.defaultLocale = "en_CA.UTF-8";

  console = {
    earlySetup = true;
    font = "ter-i16b";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  services = {
    udev = {
      enable = true;
      # A rule to allow ACPI backlight control by a non-root user from video group
      extraRules = with pkgs; ''
        ACTION=="add", SUBSYSTEM=="backlight", RUN+="${coreutils}/bin/chgrp video $sys$devpath/brightness", RUN+="${coreutils}/bin/chmod g+w $sys$devpath/brightness"
      '';
    };

    getty = {
      greetingLine = ''\e{bold}\e{green}NixOS ${config.system.nixos.label}-\m \e{lightmagenta} \n \e{yellow} \l \e{reset}'';
    };

    openssh = {
      enable = true;
      settings.X11Forwarding = true;
    };

    timesyncd.enable = true;  # Enable NTP

    gpm.enable = true;  # Enable mouse in plain Linux console mode

    libinput.enable = true;  # Enable touchpad support

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;  # Emulate PulseAudio
      jack.enable = true;
    };

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

    printing.enable = true;  # Enable CUPS

    udev.packages = [ pkgs.rtl-sdr ];

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = true;

    defaultUserShell = pkgs.fish;

    users."${userName}" = {
      uid = userId;
      isNormalUser = true;
      extraGroups = [
        "adm"
        "audio"
        "networkmanager"
        "plugdev"  # For e.g. RTL-SDR
        "video"
        "wheel"  # Enable 'sudo' for the user.
      ];
    };
  };

  # We are OK with not completely free packages in our system
  nixpkgs.config.allowUnfree = true;

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
      arduino-language-server  # Arduino Language Server based on Clangd to Arduino code autocompletion
      asciidoctor  # A faster Asciidoc processor written in Ruby
      audacity
      baobab  # Used disk space visualizer
      bash-language-server  # A language server for Bash
      bc
      brave
      btrfs-heatmap
      btrfs-progs
      btrfs-snap
      calibre
      calibre-web
      cargo  # Downloads your Rust project's dependencies and builds your project
      cargo-apk  # Tool for creating Android packages
      cargo-asm  # Display the assembly or LLVM-IR generated for Rust source code
      cargo-audit  # Audit Cargo.lock files for crates with security vulnerabilities
      cargo-bloat  # Tool and Cargo subcommand that helps you find out what takes most of the space in your executable
      cargo-cache  # Manage cargo cache (${CARGO_HOME}, ~/.cargo/), print sizes of dirs and remove dirs selectively
      cargo-clone  # Cargo subcommand to fetch the source code of a Rust crate
      cargo-deadlinks  # Cargo subcommand to check rust documentation for broken links
      cargo-depgraph  # Create dependency graphs for cargo projects using `cargo metadata` and graphviz
      cargo-duplicates  # Cargo subcommand for displaying when different versions of a same dependency are pulled in
      cargo-expand  # Cargo subcommand to show result of macro expansion
      cargo-fuzz  # Command line helpers for fuzzing
      cargo-geiger  # Detects usage of unsafe Rust in a Rust crate and its dependencies
      cargo-i18n  # Rust Cargo sub-command and libraries to extract and build localization resources to embed in your application/library
      cargo-info  # Cargo subcommand to show crates info from crates.io
      cargo-inspect  # See what Rust is doing behind the curtains
      cargo-license  # Cargo subcommand to see license of dependencies
      cargo-llvm-cov  # Cargo subcommand to easily use LLVM source-based code coverage
      cargo-lock  # Self-contained Cargo.lock parser with graph analysis
      cargo-machete  # Cargo tool that detects unused dependencies in Rust projects
      cargo-modules  # Cargo plugin for showing a tree-like overview of a crate's modules
      cargo-ndk  # Cargo extension for building Android NDK projects
      cargo-outdated  # Cargo subcommand for displaying when Rust dependencies are out of date
      cargo-profiler  # Cargo subcommand for profiling Rust binaries
      cargo-public-api  # List and diff the public API of Rust library crates between releases and commits. Detect breaking API changes and semver violations
      cargo-readme  # Generate README.md from docstrings
      cargo-release  # Cargo subcommand "release": everything about releasing a rust crate
      cargo-rr  # Cargo subcommand "rr": a light wrapper around rr, the time-travelling debugger
      cargo-shear  # Detect and remove unused dependencies from Cargo.toml
      cargo-show-asm  # Cargo subcommand showing the assembly, LLVM-IR and MIR generated for Rust code
      cargo-sort  # Tool to check that your Cargo.toml dependencies are sorted alphabetically
      cargo-spellcheck  # Checks rust documentation for spelling and grammar mistakes
      cargo-sweep  # Cargo subcommand for cleaning up unused build files generated by Cargo
      cargo-valgrind  # Cargo subcommand "valgrind": runs valgrind and collects its output in a helpful manner
      cargo-whatfeatures  # Simple cargo plugin to get a list of features for a specific crate
      ccache  # C++ compiler cache
      chromium
      clang-tools  # Standalone command line tools for C++ development (clangd, clang-format etc.)
      cmake
      cmake-language-server  # CMake LSP Implementation
      coltrane
      compsize  # Compression ratio calculator for btrfs
      darktable  # Virtual lighttable and darkroom for photographers
      denemo
      dig
      dmenu
      dunst
      exfatprogs
      exiftool  # A tool to read, write and edit EXIF meta information
      fastfetch  # Like neofetch, but much faster because written in C
      fbmark  # Linux framebuffer benchmarking tool
      feh
      ffmpeg
      file
      findutils
      firefox
      fish
      freetube
      frescobaldi
      fuzzel
      fzf
      gcc13
      gdb  # GNU debugger
      geekbench  # CPU benchmarking tool
      geeqie
      git
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
      hddtemp  # HDD temperature measurement tools
      htop
      hwinfo  # Hardware detection tool from openSUSE
      hydrogen
      jack2.dev  # JACK audio connection kit, version 2 with jackdbus
      jackmeter
      jdk  # The open-source Java Development Kit
      kbd
      kotlin-language-server  # kotlin language server
      libdrm  # Direct Rendering library and test utilities (e.g. modetest)
      libnotify
      libreoffice
      light # Control backlight brightness
      lilypond-with-fonts
      lldb  # LLVM debugger
      lm_sensors  # Onboard sensor measurement tools
      lshw
      lua-language-server  # Language server that offers Lua language support
      luajit
      marble
      mc
      meterbridge
      mi2ly
      mpc_cli
      mpd
      mpv
      mupdf
      musescore
      ncmpcpp
      neovim
      networkmanagerapplet  # Provides nm-connection-editor
      nodePackages.purescript-language-server  # Language Server Protocol server for PureScript wrapping purs ide server functionality
      nodejs_22  # Node.JS and NPM
      nufraw  # Utility to read and manipulate raw images from digital cameras
      nushell  # Modern shell written in Rust
      open-in-mpv  # Simple web extension to open videos in mpv
      pamixer  # CLI utilities to control PA & PW audio levels
      pandoc  # Converter between documentation formats
      parted
      pavucontrol
      pciutils
      pkg-config  # A tool that allows packages to find out information about other packages (wrapper script)
      pwvucontrol  # Pipewire Volume Control
      qjackctl
      qpwgraph
      qrencode
      qsynth
      rakarrack
      ripgrep
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
      sound-theme-freedesktop  # Freedesktop reference sounds
      sox
      speedtest-cli
      sway-launcher-desktop  # Note that this tool is not really tied to sway at all
      thunderbird
      tig
      tmux
      tree
      tuxguitar
      typescript
      typescript-language-server  # Language Server Protocol implementation for TypeScript using tsserver (FIXME needed?)
      universal-ctags
      unzip
      usbutils
      vifm  # Vi-like File Manager
      vim-language-server  # VImScript language server, LSP for vim script
      vkmark  # Vulkan benchmarking suite
      vlc
      vulkan-tools  # Khronos official Vulkan Tools and Utilities
      wayland-utils  # Wayland utilities (wayland-info)
      wev  # Wayland event tester (similar to xev for X11)
      wget
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
      youtube-tui
      zfs
      zip
    ];

    variables = rec {
      EDITOR = "nvim";
      VISUAL = EDITOR;
      PAGER = "less";
      LESS = "-FRX";

      # We need this to be able to build some 3rd party packages ignoring the NixOS way temporarily
      # (e.g. for building Rust package dependencies before they can be Nixified properly)
      PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
    };

    localBinInPath = true;
    homeBinInPath = true;
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Some programs need SUID wrappers, can be configured further
    # or are started in user sessions.
    # mtr.enable = true;

    fish = {
      enable = true;
      shellAliases = aliases;
      loginShellInit = ''
        set -U fish_greeting ""

        if test "$(tty)" = "/dev/tty1";
          ${pkgs.fastfetch}/bin/fastfetch
        end
      '';
    };

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
