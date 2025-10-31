# NixOS configuration for i3 GUI.
{ config, lib, pkgs, ... }: let
  sessionStartScript = with pkgs; writeShellScriptBin "startx-i3" ''
    ${xorg.xinit}/bin/startx ${i3}/bin/i3
  '';
in {
  imports = [
    ./gui-common.nix  # common GUI configuration shared by all of our graphical environments
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

  environment = {
    systemPackages = with pkgs; [
      sessionStartScript
    ];
  };
}
