# NixOS configuration for Lenovo N21 Chromebook

{ config, pkgs, lib, ... }:
let
  userName = "sergii";
  userId = 1000;

  useDM = true;

in {
  imports = [
    ./hardware-configuration.nix  # Results of the hardware scan. To redo detection: nixos-generate-config
    ../boot-efi.nix
    ../common.nix  # Common configuration shared by all of our NixOS systems
    ../gui-i3.nix  # i3 X11/GUI environment
    ../gui-icewm.nix  # IceWM X11/GUI environment
    # ../development/arduino.nix
    # ../mpd.nix
    # ../oscilloscope.nix
    # ../printing.nix
    # ../scanning.nix
    # ../sdr.nix
    # ../tv.nix
  ];

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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
