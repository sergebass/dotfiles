# NixOS configuration for lightdm display manager

{ config, pkgs, lib, ... }:
let
  wallpaperStore = pkgs.copyPathToStore "${toString ../wallpapers}";

in {

  services = {
    xserver = {
      displayManager = {
        startx.enable = lib.mkForce false;  # Force-disable startx when using a display manager

        lightdm = {
          enable = true;

          # background = "#002020";  # Solid dark teal color as a background
          background = "${wallpaperStore}/Lake-pebbles.jpg";

          greeters = {
            gtk = {
              enable = true;
              theme.name = "Adwaita-dark";
              iconTheme.name = "Tango";
              cursorTheme = {
                name = "Adwaita";
                size = 24;
              };
              clock-format = "%A, %B %d %Y -- %H:%M (%Z)";
            };
          };
        };
      };
    };
  };
}
