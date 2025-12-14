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
    ../printing.nix
    ../scanning.nix
    ../mpd.nix
    ../sdr.nix
    ../tv.nix
    ../geo.nix
    ../benchmarks.nix
    ../making-software.nix
    ../making-hardware.nix
    ../making-docs.nix
    ../making-music.nix
    ../making-photos.nix
    ../making-videos.nix
  ];

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd  # AMD Common Language Runtime for hipamd, opencl, and rocclr
      ];
      extraPackages32 = with pkgs; [
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
      brave  # Privacy-oriented browser for Desktop and Laptop computers
      calibre  # Comprehensive e-book software
      calibre-web  # Web app for browsing, reading and downloading eBooks stored in a Calibre database
      cheese  # Take photos and videos with your webcam, with fun graphical effects
      fuzzel  # Wayland-native application launcher, similar to rofi’s drun mode
      golden-cheetah  # Performance software for cyclists, runners and triathletes. Built from source and without API tokens
      kdePackages.okular # KDE document viewer (can sign PDFs: https://askubuntu.com/a/1514769)
      light # Control backlight brightness
      pdf-sign  # Tool to visually sign PDF files
      poppler-utils  # PDF rendering library
      qpwgraph  # Qt graph manager for PipeWire, similar to QjackCtl
      qrencode  # C library and command line tool for encoding data in a QR Code symbol
      signal-cli  # Command-line and dbus interface for communicating with the Signal messaging service
      signal-desktop # Private, simple, and secure messenger (nixpkgs build)
      sound-theme-freedesktop  # Freedesktop reference sounds
      thunderbird  # Full-featured e-mail client
      vivaldi  # Browser for our Friends, powerful and personal
      vivaldi-ffmpeg-codecs  # Additional support for proprietary codecs for Vivaldi and other chromium based tools
      yewtube  # Terminal based YouTube player and downloader, forked from mps-youtube
      ymuse  # GUI client for MPD
      youtube-music  # Electron wrapper around YouTube Music
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };

  nixpkgs = {
    config = {
      permittedInsecurePackages = [
        # NOTE: GoogleEarthPro also overrides gpsbabel on PATH with an older version.
        # "googleearth-pro-7.3.6.10201"  # Bundles vulnerable versions of openssl, ffmpeg, gdal, and proj
        # "qtwebengine-5.15.19"  # FIXME temporary; needed for qt5-based apps like frescobaldi
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
