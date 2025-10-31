# NixOS configuration for XFCE GUI.
{ config, lib, pkgs, ... } : {
  imports = [
    ./gui-common.nix  # common GUI configuration shared by all of our graphical environments
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
      xfce.catfish  # Handy file search tool
      xfce.mousepad  # Simple text editor for Xfce
      xfce.orage  # Simple calendar application for Xfce
      xfce.ristretto  # Fast and lightweight picture-viewer for the Xfce desktop environment
      xfce.xfce4-appfinder  # Appfinder for the Xfce4 Desktop Environment
      xfce.xfce4-clipman-plugin  # Clipboard manager for Xfce panel
      xfce.xfce4-cpufreq-plugin  # CPU Freq load plugin for Xfce panel
      xfce.xfce4-cpugraph-plugin  # CPU graph show for Xfce panel
      xfce.xfce4-dict  # Dictionary Client for the Xfce desktop environment
      xfce.xfce4-fsguard-plugin  # Filesystem usage monitor plugin for the Xfce panel
      xfce.xfce4-icon-theme  # Icons for Xfce
      xfce.xfce4-mpc-plugin  # MPD plugin for Xfce panel
      xfce.xfce4-screensaver  # Screensaver for Xfce
      xfce.xfce4-screenshooter  # Screenshot utility for the Xfce desktop
      xfce.xfce4-sensors-plugin  # Panel plug-in for different sensors using acpi, lm_sensors and hddtemp
      xfce.xfce4-session  # Provides `startxfce4` command to start Xfce session without a display manager
      xfce.xfce4-systemload-plugin  # System load plugin for Xfce panel
      xfce.xfce4-taskmanager  # Easy to use task manager for Xfce
      xfce.xfce4-terminal  # Modern terminal emulator
      xfce.xfce4-verve-plugin  # Command-line plugin
      xfce.xfce4-volumed-pulse  # Volume keys control daemon for Xfce using pulseaudio
      xfce.xfce4-weather-plugin  # Weather plugin for the Xfce desktop environment
      xfce.xfdesktop  # Xfce's desktop manager
      xfce.xfmpc  # MPD client written in GTK
      xfce.xfwm4-themes  # Themes for Xfce
    ];
  };
}
