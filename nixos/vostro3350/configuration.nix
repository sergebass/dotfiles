# NixOS configuration for Dell Vostro 3350 laptop

{ config, lib, pkgs, ... }: {

  imports = [
    ../hardware-common.nix  # Hardware configuration shared across all systems
    ../boot-grub-mbr.nix  # This old laptop does not use UEFI, so stick with MBR bootloader
    ../common.nix  # Common configuration shared by all of our NixOS systems
    ../gui-lightdm.nix  # LightDM display manager
    ../gui-i3.nix  # i3 X11/GUI environment
    ../gui-icewm.nix  # IceWM X11/GUI environment
    ../gui-xfce.nix  # XFCE X11/GUI environment
    ../gui-sway.nix  # Sway Wayland/GUI environment
    ../mpd.nix
    ../oscilloscope.nix
    ../printing.nix
    ../scanning.nix
    ../sdr.nix
    ../tv.nix
  ];

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7adf72fa-bdf4-40df-bc55-3861a27817b5";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/6aad830b-023e-49dd-a717-fe478214e30e"; }
  ];

  boot = {
    consoleLogLevel = 4;  # Warnings and errors

    initrd = {
      verbose = true;

      availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "ums_realtek" "usb_storage" "sd_mod" "sr_mod" ];
      kernelModules = [];
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [];

    kernelParams = lib.mkForce [
      "nosplash"
      "verbose"
      "boot.shell_on_fail"
      "udev.log_priority=4"
      "rd.systemd.show_status=auto"
    ];
  };

  networking = {
    hostName = "vostro3350";
    hostId = "9f7ff30f";
  };

  services = {
    udev.extraRules = with pkgs; ''
      # A rule to allow ACPI backlight control by a non-root user from video group
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${coreutils}/bin/chgrp video $sys$devpath/brightness", RUN+="${coreutils}/bin/chmod g+w $sys$devpath/brightness"
    '';

    libinput.enable = true;  # Enable touchpad support
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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
