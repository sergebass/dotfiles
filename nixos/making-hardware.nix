# NixOS configuration for making hardware (electronics, embedded firmware etc.)

{ config, lib, pkgs, ... }: {

  imports = [
    ./common.nix  # Common configuration shared by all of our NixOS systems
    ./development/arduino.nix
    ./oscilloscope.nix
  ];

  environment = {
    systemPackages = with pkgs; [
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };
}
