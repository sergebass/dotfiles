# NixOS configuration for my AMD x64 workstation in CoolerMaster-130 case

{ config, lib, pkgs, ... }: {

  imports = [
    ../hardware-common.nix  # Hardware configuration shared across all systems
    ../boot-grub-uefi.nix  # Use GRUB bootloader with UEFI support (more flexible than systemd-boot)
    ../common.nix  # Common configuration shared by all of our NixOS systems
    ../gui-lightdm.nix  # LightDM display manager
    ../gui-i3.nix  # i3 X11/GUI environment
    ../gui-icewm.nix  # IceWM X11/GUI environment
    ../gui-xfce.nix  # XFCE X11/GUI environment
    ../gui-sway.nix  # Sway Wayland/GUI environment
    ../development/android.nix
    ../development/arduino.nix
    ../mpd.nix
    ../oscilloscope.nix
    ../printing.nix
    ../scanning.nix
    ../sdr.nix
    ../tv.nix
  ];

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
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
  };

  fileSystems = let
    bootDiskDevice = "/dev/disk/by-label/NIXOS-BOOT";
    mainDiskDevice = "/dev/disk/by-label/NIXOS-ROOT";

    compressionMethod = "zstd";
  in {
    "/boot" = {
      device = bootDiskDevice;
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/" = {
      device = mainDiskDevice;
      fsType = "btrfs";
      options = [
        "compress=${compressionMethod}"
        "noatime"
      ];
    };

    "/swap" = {
      device = mainDiskDevice;
      fsType = "btrfs";
      options = [
        "subvol=swap"
        "compress=no"
        "noatime"
        "nodatacow"
        "nodatasum"
      ];
    };

    "/home" = {
      device = mainDiskDevice;
      fsType = "btrfs";
      options = [
        "subvol=home"
        "compress=${compressionMethod}" "noatime"
      ];
    };

    "/archive" = {
      device =  "/dev/disk/by-label/Sergii-Archive";
      fsType = "btrfs";
      options = [
        "compress=${compressionMethod}"
        "noatime"
        "user"
        "noauto"
      ];
    };
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  boot = {
    consoleLogLevel = 4;  # print warnings and errors during boot

    initrd = {
      verbose = true;

      availableKernelModules = [ "xhci_pci" "ahci" "ohci_pci" "ehci_pci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
      kernelModules = [ "amdgpu" ];
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [];

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
  };

  networking = {
    hostName = "cm130";

    # The primary use case is to ensure when using ZFS that a pool isn’t imported accidentally on a wrong machine.
    hostId = "b5481747";  # Result of running: head -c 8 /etc/machine-id
  };

  services = {
    udev.extraRules = with pkgs; ''
      # A rule to allow ACPI backlight control by a non-root user from video group
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${coreutils}/bin/chgrp video $sys$devpath/brightness", RUN+="${coreutils}/bin/chmod g+w $sys$devpath/brightness"
    '';

    libinput.enable = true;  # Enable touchpad support

    # Systemd service for emacs, allowing use of shared editor buffers via emacsclient
    emacs = {
      enable = true;
      package = pkgs.emacs;
    };

    xserver = {
      videoDrivers = [ "amdgpu" ];
    };

  # We still want to have Vim available even though we use Neovim as our main editor
  # (to make sure that the Vim configuration remains valid and up-to-date).
  programs.vim = {
    enable = true;
    defaultEditor = false;
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
      ardour
      asciidoctor  # A faster Asciidoc processor written in Ruby
      audacity
      avidemux  # Free video editor designed for simple video editing tasks
      bash-language-server  # A language server for Bash
      brave
      calibre
      calibre-web
      cargo  # Downloads your Rust project's dependencies and builds your project
      ccache  # C++ compiler cache
      ccls  # C/C++ language server powered by clang
      cheese  # Take photos and videos with your webcam, with fun graphical effects
      clang-tools  # Standalone command line tools for C++ development (clangd, clang-format etc.)
      cmake
      cmake-language-server  # CMake LSP Implementation
      coltrane
      darktable  # Virtual lighttable and darkroom for photographers
      denemo
      exiftool  # A tool to read, write and edit EXIF meta information
      fbmark  # Linux framebuffer benchmarking tool
      ffmpeg
      flac  # Library and tools for encoding and decoding the FLAC lossless audio file format
      frescobaldi
      fuzzel
      gcc13
      gdb  # GNU debugger
      geekbench  # CPU benchmarking tool
      geeqie
      gimp-with-plugins  # GNU Image Manipulation Program
      glmark2  # OpenGL benchmarking tool (with Wayland support)
      glxinfo  # Display OpenGL information (glxinfo and eglinfo)
      gnome-maps
      gnumake
      golden-cheetah  # Performance software for cyclists, runners and triathletes. Built from source and without API tokens
      gpsbabel  # Convert, upload and download data from GPS and Map programs
      gpscorrelate  # GPS photo correlation tool, to add EXIF geotags
      guitarix
      gxplugins-lv2
      haskell-language-server  # LSP server for GHC
      hydrogen
      jack2.dev  # JACK audio connection kit, version 2 with jackdbus
      jackmeter
      jdk  # The open-source Java Development Kit
      jqp  # TUI playground to experiment with jq
      kdePackages.marble
      kdePackages.okular # KDE document viewer (can sign PDFs: https://askubuntu.com/a/1514769)
      kotlin-language-server  # kotlin language server
      libdrm  # Direct Rendering library and test utilities (e.g. modetest)
      libreoffice
      light # Control backlight brightness
      lilypond-with-fonts
      lldb  # LLVM debugger
      llvmPackages.clangUseLLVM  # C language family frontend for LLVM (wrapper script)
      lua-language-server  # Language server that offers Lua language support
      luajit
      meld  # Visual diff and merge tool
      meterbridge  # Various meters (VU, PPM, DPM, JF, SCO) for Jack Audio Connection Kit
      mi2ly
      musescore
      nodePackages.purescript-language-server  # Language Server Protocol server for PureScript wrapping purs ide server functionality
      nodejs_22  # Node.JS and NPM
      nufraw  # Utility to read and manipulate raw images from digital cameras
      open-pdf-sign  # Digitally sign PDF files from your commandline
      pandoc  # Converter between documentation formats
      pdf-sign  # Tool to visually sign PDF files
      pkg-config  # A tool that allows packages to find out information about other packages (wrapper script)
      poppler_utils  # PDF rendering library
      qjackctl
      qpwgraph
      qrencode
      qsynth
      rakarrack
      rust-analyzer  # A modular compiler frontend for the Rust language
      rust-bindgen  # Automatically generates Rust FFI bindings to C (and some C++) libraries
      rustc  # Rust compiler
      rustfmt  # Tool for formatting Rust code according to style guidelines
      signal-cli  # Command-line and dbus interface for communicating with the Signal messaging service
      signal-desktop # Private, simple, and secure messenger (nixpkgs build)
      simplescreenrecorder  # Screen recorder for Linux
      sound-theme-freedesktop  # Freedesktop reference sounds
      sox
      sqlitebrowser  # DB Browser for SQLite
      thunderbird
      tuxguitar
      typescript
      typescript-language-server  # Language Server Protocol implementation for TypeScript using tsserver (https://github.com/typescript-language-server/typescript-language-server)
      vim-language-server  # VImScript language server, LSP for vim script
      vkmark  # Vulkan benchmarking suite
      vorbis-tools  # Extra tools for Ogg-Vorbis audio codec
      vulkan-tools  # Khronos official Vulkan Tools and Utilities
      yaml-language-server  # Language Server for YAML Files
      yewtube
      ymuse  # GUI client for MPD
      youtube-music
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config = {
      permittedInsecurePackages = [
        # "googleearth-pro-7.3.6.9796"  # NOTE: overrides gpsbabel on PATH with an older version. Uses compromised deps.
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
