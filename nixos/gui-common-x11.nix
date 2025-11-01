# NixOS configuration shared across all GUI environments
{ config, lib, pkgs, ... } : {
  imports = [
    ./gui-common.nix  # common GUI configuration shared by all of our graphical environments
  ];

  services = {
    xserver = {
      enable = true;

      # X11 Keyboard configuration
      xkb = {
        layout = "us(altgr-intl),ua";
        options = "grp:shift_caps_toggle,grp:shifts_toggle,grp_led:scroll,caps:escape,compose:rctrl-altgr,terminate:ctrl_alt_bksp";
      };

      desktopManager = {
        xterm.enable = false;
        wallpaper = {
          mode = "max";
          combineScreens = false;
        };
      };
    };
  };

  environment = {
    # X11-specific core apps
    systemPackages = with pkgs; [
      scrot
      xorg.xev
      xorg.xkill
      xorg.xrandr
      xorg.xsetroot
    ];
  };
}
