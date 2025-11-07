# Boot configuration for extlinux bootloader
{ config, lib, pkgs, ... } : {

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };
}
