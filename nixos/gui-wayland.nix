# NixOS configuration for GUI/Wayland.
{ config, lib, pkgs, ... } : {
  imports = [
    ./gui-common.nix  # common configuration shared across GUI-based environments
  ];

  programs = {
    # Sway is a Wayland compositor
    sway = {
      enable = true;
      extraPackages= with pkgs; [
        grim
        mako  # Pop-up notifications
        rofi-wayland
        slurp
        swaybg
        swayfx
        swayidle
        swayimg
        swaylock
        wl-clipboard
      ];
      extraOptions = [
        "--verbose"
      ];
      extraSessionCommands = ''
        # Some apps need explicit hints to choose Wayland over X11
        export GDK_BACKEND=wayland
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export NIXOS_OZONE_WL=1
        export ELECTRON_OZONE_PLATFORM_HINT=wayland
        export MOZ_ENABLE_WAYLAND=1
      '';
      wrapperFeatures.gtk = true;
    };
  };

  xdg.portal = {
    enable = true;  # Enable xdg desktop integration (https://github.com/flatpak/xdg-desktop-portal).
    xdgOpenUsePortal = true;  # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1. This will make xdg-open use the portal to open programs...
    wlr.enable = true;  # Enable desktop portal for wlroots-based desktops.
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      wayland-utils  # Wayland utilities (wayland-info)
      wev  # Wayland event tester (similar to xev for X11)
    ];
  };
}
