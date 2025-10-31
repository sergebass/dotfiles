# NixOS configuration for XFCE GUI.
{ config, lib, pkgs, ... } : {
  imports = [
    ./gui-common-x11.nix  # common configuration shared across X11-based environments
  ];

  services = {
    xserver = {
      desktopManager = {
        xfce = {
          enable = true;
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      xfce.xfce4-sensors-plugin  # Panel plug-in for different sensors using acpi, lm_sensors and hddtemp
    ];
  };
}
