# Boot configuration for systemd-boot UEFI bootloader
{ config, lib, pkgs, ... } : {

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      efibootmgr  # Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager
    ];
  };
}
