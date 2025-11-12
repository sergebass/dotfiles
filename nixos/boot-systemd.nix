# Boot configuration for systemd-boot UEFI bootloader
{ config, lib, pkgs, ... } : {

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
