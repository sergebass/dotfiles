# NixOS configuration for IceWM GUI.
{ config, lib, pkgs, ... }: let
  sessionStartScript = with pkgs; writeShellScriptBin "startx-icewm" ''
    ${xorg.xinit}/bin/startx ${icewm}/bin/icewm
  '';
in {
  imports = [
    ./gui-common.nix  # common GUI configuration shared by all of our graphical environments
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

  environment = {
    systemPackages = with pkgs; [
      sessionStartScript
    ];
  };
}
