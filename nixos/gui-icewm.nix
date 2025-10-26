# NixOS configuration for IceWM GUI.
{ config, lib, pkgs, ... } : {
  imports = [
    ./gui-common-x11.nix  # common configuration shared across X11-based environments
  ];

  services = {
    xserver = {
      windowManager = {
        icewm = {
          enable = true;
        };
      };
    };
  };
}
