# NixOS configuration for Lenovo N21 Chromebook

{ config, pkgs, lib, ... }:
let
  userName = "sergii";
  userId = 1000;

  useDisplayManager = true;

in {
  imports = [
    ../hardware-common.nix  # Hardware configuration shared across all systems
    ../boot-efi.nix
    ../common.nix  # Common configuration shared by all of our NixOS systems
    ../gui-i3.nix  # i3 X11/GUI environment
    ../gui-icewm.nix  # IceWM X11/GUI environment
    ../mpd.nix
    ../sdr.nix
    ../tv.nix
    ../scanning.nix
    ../printing.nix
    # ../development/arduino.nix
    # ../oscilloscope.nix
  ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/2C27-4351";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    "/" = {
      device = "/dev/disk/by-uuid/4bb679ac-b061-4667-84db-107a931b3a89";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  swapDevices = [];  # The SSD on this Chromebook is tiny, there is no room for swap, unfortunately.

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "usb_storage" "sd_mod" "sdhci_acpi" ];
    initrd.kernelModules = [];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [];
  };

  networking = {
    hostName = "n21";

    # The primary use case is to ensure when using ZFS that a pool isn’t imported accidentally on a wrong machine.
    hostId = "30a84cb2";  # Result of running: head -c 8 /etc/machine-id
  };

  services = {
    udev = {
      enable = true;

      # A rule to allow ACPI backlight control by a non-root user from video group
      extraRules = with pkgs; ''
        ACTION=="add", SUBSYSTEM=="backlight", RUN+="${coreutils}/bin/chgrp video $sys$devpath/brightness", RUN+="${coreutils}/bin/chmod g+w $sys$devpath/brightness"
      '';
    };

    xserver = {
      displayManager = {
        startx.enable = ! useDisplayManager;

        lightdm = {
          enable = useDisplayManager;
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
    };

    libinput.enable = true;  # Enable touchpad support
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      # qrencode
      # ymuse  # GUI client for MPD
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
