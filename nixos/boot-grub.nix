# Boot configuration for GRUB bootloader
{ config, lib, pkgs, ... } : {

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
      };
    };
  };
}
