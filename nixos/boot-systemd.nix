# Boot configuration for systemd-boot UEFI bootloader
{ config, lib, pkgs, ... } : {

  boot = {
    loader = {
      timeout = lib.mkForce 3;  # Timeout in seconds before default entry is booted

      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        memtest86.enable = true;  # Memtest86+ is a program for testing memory.
        consoleMode = "auto";  # Auto-pick the video mode
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      efibootmgr  # Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager
    ];
  };
}
