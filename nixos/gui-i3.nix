# NixOS configuration for i3 GUI.
{ config, lib, pkgs, ... } : {
  imports = [
    ./gui-common-x11.nix  # common configuration shared across X11-based environments
  ];

  services = {
    xserver = {
      windowManager = {
        i3 = {
          enable = true;
          extraPackages = with pkgs; [
            i3status
            i3lock
          ];
        };
      };
    };
  };
}
