# The list of core GUI packages that I need on every NixOS system

pkgs: with pkgs; [
  alacritty  # Cross-platform, GPU-accelerated terminal emulator
  chromium  # Open source web browser from Google
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
  nushell  # Modern shell written in Rust
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
  sway-launcher-desktop  # Note that this tool is not really tied to sway at all
  system-config-printer  # Printer configuration/pipeline control UI
  vlc  # Cross-platform media player and streaming server
  xdg-dbus-proxy  # DBus proxy for Flatpak and others
  xdg-launch  # A command line XDG compliant launcher and tools
  xdg-terminal-exec  # Reference implementation of the proposed XDG Default Terminal Execution Specification
  xdg-user-dirs  # A tool to help manage well known user directories like the desktop folder and the music folder
  xdg-utils  # A set of command line tools that assist applications with a variety of desktop integration tasks
  xorg.xkill
  xorg.xrandr
  xorg.xsetroot
]
