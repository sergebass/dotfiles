# NixOS configuration for lightdm display manager

{ config, pkgs, lib, ... }:
let
  userName = "sergii";

in {

  services = {
    xserver = {
      displayManager = {
        startx.enable = lib.mkForce false;  # Force-disable startx when using a display manager

        lightdm = {
          enable = true;
          greeter.enable = true;
          # background = /home/${userName}/.background-image;
          background = "#002020";  # Solid dark teal color as a background
        };
      };
    };
  };
}
