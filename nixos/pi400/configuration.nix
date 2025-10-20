# NixOS configuration for Raspberry Pi 400 implementing a software MIDI synthesizer appliance

{ config, pkgs, lib, ... }:
let
  userName = "sergii";
  userId = 1000;

  synthUserName = "synth";

  synthConnectionScript = with pkgs; writeShellScriptBin "synth.sh" ''
    echo "Killing any running fluidsynth instances..."
    ${killall}/bin/killall fluidsynth
    ${coreutils-full}/bin/sleep 2

    echo "Launching fluidsynth MIDI synthesizer..."
    # Use this for ALSA: --audio-driver alsa -o audio.alsa.device=default:CARD=Device
    ${fluidsynth}/bin/fluidsynth --audio-driver pulseaudio --midi-driver alsa_seq --server --no-shell --gain 1 --reverb on --chorus on --sample-rate 48000 ${soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2 &

    echo "Waiting a bit until fluidsynth is up and running..."
    ${coreutils-full}/bin/sleep 20

    echo "Connecting Keystation MIDI keyboard to fluidsynth MIDI synthesizer..."
    ${alsa-utils}/bin/aconnect -l
    ${alsa-utils}/bin/aconnect "USB Keystation:0" "FLUID Synth:0"

    echo "Should be connected now. Try playing something..."
  '';

in {
  imports = [
    ../common.nix  # Common configuration shared by all of our NixOS systems
    ../mpd.nix
    ./hardware-configuration.nix  # Results of the hardware scan. To redo detection: nixos-generate-config
  ];

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    kernelPackages = pkgs.linuxPackages;

    kernelParams = lib.mkForce [
      "verbose"
      "nosplash"
    ];

    tmp.useTmpfs = true;  # Save flash storage from some wear and tear

    supportedFilesystems = [
      "btrfs"
      "exfat"
      "ntfs"
      "ntfs3"
      "zfs"
    ];

    zfs = {
      forceImportRoot = false;
    };
  };

  networking = {
    hostName = "pi400";

    # The primary use case is to ensure when using ZFS that a pool isn’t imported accidentally on a wrong machine.
    hostId = "c19a013e";  # Result of running: head -c 8 /etc/machine-id

    firewall = {
      enable = true;
    };
  };

  services = {
    udev = {
      enable = true;

      extraRules = with pkgs; ''
      '';
    };

    gvfs.enable = true;  # Mount, trash, and other functionalities
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${synthUserName}" = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "networkmanager"
    ];
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      ctags
      fluidsynth
      killall
      links2
      mpv
      pamix
      raspberrypi-eeprom
      soundfont-fluid
    ] ++ [
      # Our custom scripts
      synthConnectionScript
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ] ++ import ../packages-core-gui.nix pkgs;
  };

  # programs = {

  #   # FIXME this only has to work for user synth!
  #   fish = {
  #     enable = true;
  #     shellAliases = aliases;
  #     loginShellInit = ''
  #       set -U fish_greeting ""

  #       # Auto-start our MIDI keyboard -> fluidsynth link when logging in on tty1
  #       if test "$(tty)" = "/dev/tty1";
  #         ${synthConnectionScript}/bin/synth.sh
  #       end
  #     '';
  #   };
  # };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
