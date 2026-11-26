# NixOS configuration for LXQt GUI.
{ config, lib, pkgs, ... }: {

  imports = [
    ./gui-common.nix  # common GUI configuration shared by all of our graphical environments
    ./gui-common-x11.nix  # common configuration shared across X11-based environments
  ];

  services = {
    xserver = {
      desktopManager = {
        lxqt = {
          enable = true;
          extraPackages = with pkgs; with pkgs.lxqt; [
          ];
        };
      };
    };

    displayManager.sessionPackages = [
      pkgs.lxqt.lxqt-wayland-session  # Allow Wayland sessions explicitly
    ];

    xscreensaver.enable = true;
  };

  xdg.portal.lxqt.enable = true;

  # We need this to avoid "password initialization error" dialogs when XScreensaver is running
  security.pam.services.xscreensaver.enable = true;

  environment = {
    systemPackages = with pkgs; [
    ];
  };
}
