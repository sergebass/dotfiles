# NixOS configuration for making videos (video editors, file converters etc.)

{ config, lib, pkgs, ... }: {

  imports = [
    ./common.nix  # Common configuration shared by all of our NixOS systems
  ];

  environment = {
    systemPackages = with pkgs; [
      avidemux  # Free video editor designed for simple video editing tasks
      ffmpeg  # Complete, cross-platform solution to record, convert and stream audio and video
      simplescreenrecorder  # Screen recorder for Linux
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };
}
