# NixOS configuration for making photos (graphics editors, raw image file converters etc.)

{ config, lib, pkgs, ... }: {

  imports = [
    ./common.nix  # Common configuration shared by all of our NixOS systems
  ];

  environment = {
    systemPackages = with pkgs; [
      darktable  # Virtual lighttable and darkroom for photographers
      exiftool  # A tool to read, write and edit EXIF meta information
      geeqie  # Lightweight GTK based image viewer
      gimp-with-plugins  # GNU Image Manipulation Program
      gpscorrelate  # GPS photo correlation tool, to add EXIF geotags
      nufraw  # Utility to read and manipulate raw images from digital cameras
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };
}
