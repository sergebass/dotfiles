# NixOS configuration for Dell Vostro 3350 laptop

{ config, lib, pkgs, ... }:
let
  useDisplayManager = true;

in {
  imports = [
    ./hardware-configuration.nix  # Results of the hardware scan. To redo detection: nixos-generate-config
    ../boot-grub.nix  # This old laptop does not use UEFI, so stick with GRUB2
    ../common.nix  # Common configuration shared by all of our NixOS systems
    ../gui-xfce.nix  # XFCE X11/GUI environment
    ../gui-i3.nix  # i3 X11/GUI environment
    ../gui-icewm.nix  # IceWM X11/GUI environment
    ../gui-wayland.nix
    ../mpd.nix
    ../oscilloscope.nix
    ../printing.nix
    ../scanning.nix
    ../sdr.nix
    ../tv.nix

  ];

  networking = {
    hostName = "vostro3350";
    hostId = "9f7ff30f";
  };

  services = {
    udev = {
      enable = true;
      # A rule to allow ACPI backlight control by a non-root user from video group
      extraRules = with pkgs; ''
        ACTION=="add", SUBSYSTEM=="backlight", RUN+="${coreutils}/bin/chgrp video $sys$devpath/brightness", RUN+="${coreutils}/bin/chmod g+w $sys$devpath/brightness"
      '';
    };

    libinput.enable = true;  # Enable touchpad support

    displayManager = {
      defaultSession = "xfce";
    };
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      audacity
      calibre
      coltrane
      ffmpeg
      frescobaldi
      geeqie
      glmark2
      gnome-maps
      guitarix
      gxplugins-lv2
      hydrogen
      jackmeter
      libreoffice
      light # Control backlight brightness
      lilypond-with-fonts
      luajit
      meterbridge
      mi2ly
      mpc_cli
      musescore
      qjackctl
      qpwgraph
      qrencode
      qsynth
      rakarrack
      signal-cli
      signal-desktop
      sox
      speedtest-cli
      thunderbird
      tuxguitar
      xsane  # Graphical scanning frontend for sane
      ymuse  # GUI client for MPD
      youtube-tui
    ];
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
  system.stateVersion = "24.05"; # Did you read the comment?
}
