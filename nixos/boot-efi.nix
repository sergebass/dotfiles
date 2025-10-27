# Boot configuration for EFI bootloader
{ config, lib, pkgs, ... } : {

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
