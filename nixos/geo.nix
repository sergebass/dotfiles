# NixOS configuration for geography-related stuff

{ config, lib, pkgs, ... }: {

  imports = [
    ./common.nix  # Common configuration shared by all of our NixOS systems
  ];

  environment = {
    systemPackages = with pkgs; [
      gnome-maps  # Map application for GNOME 3
      gpsbabel  # Convert, upload and download data from GPS and Map programs
      kdePackages.marble  # Virtual Globe and World Atlas that you can use to learn more about the Earth
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };
}
