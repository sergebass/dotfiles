# NixOS configuration shared across all GUI environments
{ config, lib, pkgs, ... } : {
  imports = [
    ./common.nix  # Common configuration shared by all of our NixOS systems
  ];

  services = {
    gvfs.enable = true;  # Mount, trash, and other functionalities
    blueman.enable = true;  # Bluetooth manager (GUI)
  };

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  xdg.portal = {
    enable = true;  # Enable xdg desktop integration (https://github.com/flatpak/xdg-desktop-portal).
    xdgOpenUsePortal = true;  # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1. This will make xdg-open use the portal to open programs...
    lxqt.enable = true;  # Enable the desktop portal for the LXQt desktop environment.

    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome  # Backend implementation for xdg-desktop-portal for the GNOME desktop environment
      xdg-desktop-portal-gtk  # Desktop integration portals for sandboxed apps
      xdg-desktop-portal-xapp  # Backend implementation for xdg-desktop-portal for Cinnamon, MATE, Xfce
    ];
  };

  environment = {
    # GUI apps shared across all windowing environments (X11, Wayland etc.)
    systemPackages = with pkgs; [
      alacritty  # Cross-platform, GPU-accelerated terminal emulator
      baobab  # Used disk space visualizer
      (chromium.override { enableWideVine = true; })  # FOSS Chromim browser + Widevine DRM
      dmenu  # Generic, highly customizable, and efficient menu for the X Window System
      dunst  # Lightweight and customizable notification daemon
      feh  # Light-weight image viewer
      firefox  # Web browser built from Firefox source tree
      freetube  # Open Source YouTube app for privacy
      gparted  # Graphical disk partitioning tool
      libnotify  # Library that sends desktop notifications to a notification daemon
      mpv  # General-purpose media player, fork of MPlayer and mplayer2
      mupdf  # Lightweight PDF, XPS, and E-book viewer and toolkit written in portable C
      networkmanagerapplet  # Provides nm-connection-editor
      open-in-mpv  # Simple web extension to open videos in mpv
      pavucontrol  # PulseAudio Volume Control
      pwvucontrol  # Pipewire Volume Control
      rofi  # Window switcher, run dialog and dmenu replacement
      rofi-bluetooth  # Rofi-based interface to connect to bluetooth devices and display status info
      rofi-calc  # Do live calculations in rofi!
      rofi-file-browser  # Use rofi to quickly open files
      rofi-mpd  # Rofi menu for interacting with MPD written in Python
      rofi-pulse-select  # Rofi-based interface to select source/sink (aka input/output) with PulseAudio
      rofi-systemd  # Control your systemd units using rofi
      rofi-top  # Plugin for rofi that emulates top behaviour
      smplayer  # Complete front-end for MPlayer
      sound-theme-freedesktop  # Freedesktop reference sounds
      sway-launcher-desktop  # Note that this tool is not really tied to sway at all
      vlc  # Cross-platform media player and streaming server
      xdg-dbus-proxy  # DBus proxy for Flatpak and others
      xdg-launch  # A command line XDG compliant launcher and tools
      xdg-terminal-exec  # Reference implementation of the proposed XDG Default Terminal Execution Specification
      xdg-user-dirs  # A tool to help manage well known user directories like the desktop folder and the music folder
      xdg-utils  # A set of command line tools that assist applications with a variety of desktop integration tasks
    ];
  };
}
