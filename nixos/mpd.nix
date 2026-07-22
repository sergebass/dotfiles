# NixOS configuration for Music Player Daemon (MPD) music server support.
{ config, lib, pkgs, ... }:
let
  # FIXME TODO get rid of user name and ID duplication
  userName = "sergii";
  userId = 1000;

in {
  services = {
    # Music Player Daemon
    mpd = {
      enable = true;
      startWhenNeeded = true;  # systemd feature: only start MPD service upon connection to its socket

      user = userName;  # Do not run as root

      network = {
        listenAddress = "any";  # Allow non-localhost connections
        port = 6600;  # port 6600 is the default
      };

      musicDirectory = "/home/${userName}/music";
      playlistDirectory = "/home/${userName}/music/playlists";

      settings = {
        audio_output = [
          {
            type = "pipewire";
            name = "PipeWire";
          }
          {
            type = "pulse";
            name = "PulseAudio";
            # server = "remote_server"; # optional
            # sink = "remote_server_sink"; # optional
          }
          {
            type = "alsa";
            name = "ALSA (default)";
            # device = "hw:0,0"; # optional
            # format = "44100:16:2"; # optional
            # mixer_type = "hardware"; # optional
            # mixer_device = "default"; # optional
            # mixer_control = "PCM"; # optional
            # mixer_index = "0"; # optional
          }
        ];
      };
    };
  };

  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString userId}"; # MPD will look inside this directory for the PipeWire socket.
  };
}
