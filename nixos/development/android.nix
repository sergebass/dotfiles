# NixOS configuration for Android development support.
{ config, lib, pkgs, ... } : {
  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      adbfs-rootless  # Mount Android phones on Linux with adb, no root required
      android-studio
      android-studio-tools
      android-tools  # Android SDK platform tools
    ];
  };
}
