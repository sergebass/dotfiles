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

      displayManager = {
        # Note that in case a display manager is used, startx.enable should be false (use `lib.mkForce false` to override)
        startx.enable = true;  # Allow users to start X server with `startx` command from console by default
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
      rxvt-unicode  # Clone of the well-known terminal emulator rxvt
      scrot  # Command-line screen capture utility
      xbacklight  # Utility to adjust X backlight brightness using RandR extension
      xclip  # Tool to access the X clipboard from a console application
      xdg-utils  # Set of command line tools that assist applications with a variety of desktop integration tasks
      xev  # X event monitor
      xinit  # X server & client startup utilities (includes startx)
      xkill  # Utility to forcibly terminate X11 clients
      xrandr  # Command line interface to X11 Resize, Rotate, and Reflect (RandR) extension
      xsel  # Command-line program for getting and setting the contents of the X selection
      xsetroot  # Root window parameter setting utility for X
      xterm  # Terminal emulator for the X Window System
    ];
  };
}
