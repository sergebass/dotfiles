# NixOS configuration for i3 GUI.
# { config, lib, pkgs, xmonad-contexts, ... }: let
{ config, lib, pkgs, ... }: let
  sessionStartScript = with pkgs; writeShellScriptBin "startx-xmonad" ''
    ${xinit}/bin/startx ${xmonad-with-packages}/bin/xmonad
  '';
in {

  imports = [
    ./gui-common.nix  # common GUI configuration shared by all of our graphical environments
    ./gui-common-x11.nix  # common configuration shared across X11-based environments
  ];

  services = {
    xserver = {
      windowManager = {
        # See https://wiki.nixos.org/wiki/XMonad for additional configuration tips
        # See https://search.nixos.org/options?query=services.xserver.windowManager.xmonad for supported options
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          extraPackages = haskellPackages: [
            haskellPackages.monad-logger
            haskellPackages.xmobar
          ];

          # Custom configuration location
          # config = builtins.readFile ../path/to/xmonad.hs;

          # Arguments for the Haskell compiler
          # ghcArgs = [
          #   "-hidir /tmp" # place interface files in /tmp, otherwise ghc tries to write them to the nix store
          #   "-odir /tmp" # place object files in /tmp, otherwise ghc tries to write them to the nix store
          #   "-i${xmonad-contexts}" # tell ghc to search in the respective nix store path for the module
          # ];
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      alacritty  # Cross-platform, GPU-accelerated terminal emulator
      feh  # Light-weight image viewer
      i3lock  # Simple screen locker like slock
      i3status  # Generates a status line for i3bar, dzen2, xmobar or lemonbar
      scrot  # Command-line screen capture utility
      sessionStartScript  # Custom script to launch xmonad session
      thunar  # Xfce file manager
      thunar-archive-plugin  # Thunar plugin providing file context menus for archives
      thunar-media-tags-plugin  # Thunar plugin providing tagging and renaming features for media files
      thunar-shares-plugin  # Thunar plugin providing quick folder sharing using Samba without requiring root access
      thunar-vcs-plugin  # Thunar plugin providing support for Subversion and Git
      thunar-volman  # Thunar extension for automatic management of removable drives and media
    ];
  };
}
