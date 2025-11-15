# Boot configuration for GRUB bootloader installed in UEFI systems
{ config, lib, pkgs, ... } : {

  imports = [
    ./boot-grub-common.nix  # Common configuration shared across all GRUB setups
  ];

  boot = {
    loader = {
      grub = {
        device = "nodev";  # GRUB boot menu will be generated, but GRUB itself will not actually be installed.
        efiSupport = true;
        copyKernels = true;  # Copy the kernel and initrd to the boot partition
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
