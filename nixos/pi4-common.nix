# NixOS configuration shared across multiple Pi4 boards

{ config, pkgs, lib, ... }: {
  imports = [
    ../hardware-common.nix  # Hardware configuration shared across all systems
    ../boot-extlinux.nix  # We use extlinux to boot the Pi
    ../common.nix  # Common configuration shared by all of our NixOS systems
  ];

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];  # Save microSD card flash (or SSD) storage from extra wear
    };
  };

  swapDevices = [];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "usbhid" ];
      kernelModules = [];
    };

    kernelModules = [];
    extraModulePackages = [];

    kernelParams = lib.mkForce [
      "verbose"
      "nosplash"
    ];
  };

  services = {
    udev.extraRules = with pkgs; ''
    '';
  };

  environment = {
    systemPackages = with pkgs; [
      raspberrypi-eeprom
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
