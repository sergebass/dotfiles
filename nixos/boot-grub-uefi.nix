# Boot configuration for GRUB bootloader
{ config, lib, pkgs, ... } : {

  boot = {
    loader = {
      timeout = 3;  # Timeout in seconds before default entry is booted

      systemd-boot.enable = false;  # Make sure there is no bootloader clash

      grub = {
        enable = true;
        device = "nodev";  # GRUB boot menu will be generated, but GRUB itself will not actually be installed.
        efiSupport = true;
        useOSProber = true;
        copyKernels = true;  # Copy the kernel and initrd to the boot partition
        fsIdentifier = "label";  # Refer to filesystems by their labels in GRUB config (e.g. root=LABEL=NIXOS-ROOT)

        zfsSupport = true;  # Enable ZFS support in GRUB

        memtest86.enable = true;  # Enable memtest86+ in GRUB menu

        timeoutStyle = "menu";  # Show the GRUB menu during the timeout period
        default = 0;  # Can also be set to “saved”, which will make GRUB select the menu item that was used at the last boot.

        configurationLimit = 100;  # Maximum number of menu entries to keep in GRUB config

        extraEntries = ''
            menuentry "Reboot" {
                echo "System rebooting..."
                sleep 2
                reboot
            }

            menuentry "Power Off" {
                echo "System shutting down..."
                sleep 2
                halt
            }
        '';

        extraConfig = ''
          # Custom GRUB configuration options
        '';

        # gfxmodeEfi = "1920x1080";  # Resolution for GRUB menu in UEFI systems
        # gfxpayloadEfi = "keep";  # Keep the resolution set in the firmware/UEFI when loading Linux kernel

        # gfxmodeBios = "1920x1080";  # Resolution for GRUB menu in BIOS systems
        # gfxpayloadBios = "keep";  # Keep the resolution set in the firmware/UEFI when loading Linux kernel

        # fontSize = 14;
        # font = ../.local/share/fonts/InconsolataNerdFontMono-Regular.ttf;
        # font = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";

        # backgroundColor = "#002020";  # Teal (Background color to be used for GRUB to fill the areas the image isn’t filling)

        # splashImage = null;  # Set to null to run GRUB in text mode.
        # splashImage = ../wallpapers/Lake-pebbles.jpg;
        # splashMode = "stretch";  # Whether to stretch the image or show the image in the top-left corner unstretched.

        # theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
        # theme = "${pkgs.minimal-grub-theme}";
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };
}
