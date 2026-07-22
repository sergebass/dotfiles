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
      catfish  # Handy file search tool
      mousepad  # Simple text editor for Xfce
      orage  # Simple calendar application for Xfce
      ristretto  # Fast and lightweight picture-viewer for the Xfce desktop environment
      xfce4-appfinder  # Appfinder for the Xfce4 Desktop Environment
      xfce4-clipman-plugin  # Clipboard manager for Xfce panel
      xfce4-cpufreq-plugin  # CPU Freq load plugin for Xfce panel
      xfce4-cpugraph-plugin  # CPU graph show for Xfce panel
      xfce4-dict  # Dictionary Client for the Xfce desktop environment
      xfce4-fsguard-plugin  # Filesystem usage monitor plugin for the Xfce panel
      xfce4-icon-theme  # Icons for Xfce
      xfce4-mpc-plugin  # MPD plugin for Xfce panel
      xfce4-screensaver  # Screensaver for Xfce
      xfce4-screenshooter  # Screenshot utility for the Xfce desktop
      xfce4-sensors-plugin  # Panel plug-in for different sensors using acpi, lm_sensors and hddtemp
      xfce4-session  # Provides `startxfce4` command to start Xfce session without a display manager
      xfce4-systemload-plugin  # System load plugin for Xfce panel
      xfce4-taskmanager  # Easy to use task manager for Xfce
      xfce4-terminal  # Modern terminal emulator
      xfce4-verve-plugin  # Command-line plugin
      xfce4-volumed-pulse  # Volume keys control daemon for Xfce using pulseaudio
      xfce4-weather-plugin  # Weather plugin for the Xfce desktop environment
      xfdesktop  # Xfce's desktop manager
      xfmpc  # MPD client written in GTK
      xfwm4-themes  # Themes for Xfce
    ];
  };
}
