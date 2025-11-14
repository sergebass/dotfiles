# Boot configuration for GRUB bootloader
{ config, lib, pkgs, ... } : {

  boot = {
    loader = {
      systemd-boot.enable = false;  # Make sure there is no bootloader clash

      grub = {
        enable = true;
        device = "nodev";  # GRUB boot menu will be generated, but GRUB itself will not actually be installed.
        efiSupport = true;
        useOSProber = true;
        copyKernels = true;  # Copy the kernel and initrd to the boot partition
        fsIdentifier = "label";  # Refer to filesystems by their labels in GRUB config (e.g. root=LABEL=NIXOS-ROOT)

        memtest86.enable = true;  # Enable memtest86+ in GRUB menu

        extraEntries = ''
            menuentry "Reboot" {
                reboot
            }
            menuentry "Power Off" {
                halt
            }
        '';
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };
}
