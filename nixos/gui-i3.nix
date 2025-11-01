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
            i3-back  # i3/Sway utility to switch focus to your last focused window
            i3-volume  # Volume control with on-screen display notifications
            i3lock  # Simple screen locker like slock
            i3status  # Stock i3 status bar
            i3status-rust  # Very resource-friendly and feature-rich replacement for i3status
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
