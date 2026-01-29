# NixOS configuration for television (TV) tuner support (dongles, playback etc.)
{ config, lib, pkgs, ... } : {
  hardware = {
    firmware = with pkgs; [
      libreelec-dvb-firmware  # DVB firmware from LibreELEC (for many TV tuner devices)
    ];
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      mpv  # General-purpose media player, fork of MPlayer and mplayer2
      mpvc  # Mpc-like control interface for mpv
      smplayer  # Complete front-end for MPlayer
      vlc  # Cross-platform media player and streaming server
      w_scan2  # A small channel scan tool which generates ATSC, DVB-C, DVB-S/S2 and DVB-T/T2 channels.conf files. Use: w_scan2 -fa -c CA > channels.conf
    ];
  };
}
