# Boot configuration for GRUB bootloader installed in MBR
{ config, lib, pkgs, ... } : {

  imports = [
    ./boot-grub-common.nix  # Common configuration shared across all GRUB setups
  ];

  boot = {
    loader = {
      grub = {
        devices = [ "/dev/sda" ];
      };
    };
  };
}
