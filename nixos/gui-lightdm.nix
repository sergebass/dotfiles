# NixOS configuration for lightdm display manager

{ config, pkgs, lib, ... }:
let
  userName = "sergii";

in {

  services = {
    xserver = {
      displayManager = {
        startx.enable = false;

        lightdm = {
          enable = true;
          greeter.enable = true;
          background = /home/${userName}/.background-image;
        };
      };
    };
  };
}
