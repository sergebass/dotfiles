# NixOS configuration for KDE Plasma GUI.
{ config, lib, pkgs, ... } : {
  imports = [
    ./gui-common.nix  # common GUI configuration shared by all of our graphical environments
    ./gui-common-x11.nix  # common configuration shared across X11-based environments
  ];

  services = {
    desktopManager = {
      plasma6 = {
        enable = true;
        enableQt5Integration = true;
      };
    };
  };

  qt.platformTheme = "qt5ct";  # Use qt5ct to configure Qt5 settings (e.g. theme, fonts, icons, etc.)

  environment = {
    systemPackages = with pkgs; [
    ]; 
  };
}
