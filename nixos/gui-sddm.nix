# NixOS configuration for SDDM display manager

{ config, pkgs, lib, ... }: {

  services = {
    xserver = {
      displayManager = {
        startx.enable = lib.mkForce false;  # Force-disable startx when using a display manager

        sddm = {
          enable = true;

          wayland = {
            enable = true;  # Experimental Wayland support
          };
        };
      };
    };
  };
}
