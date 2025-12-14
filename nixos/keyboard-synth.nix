# NixOS configuration for MIDI keyboard connected to a software synthesizer

{ config, pkgs, lib, ... }:
let
  synthUserName = "synth";

  synthConnectionScript = with pkgs; writeShellScriptBin "synth.sh" ''
    echo "Killing any running fluidsynth instances..."
    ${psmisc}/bin/killall fluidsynth
    ${coreutils-full}/bin/sleep 2

    echo "Launching fluidsynth MIDI synthesizer..."
    # Use this for ALSA: --audio-driver alsa -o audio.alsa.device=default:CARD=Device
    ${fluidsynth}/bin/fluidsynth --audio-driver pulseaudio --midi-driver alsa_seq --server --no-shell --gain 1 --reverb on --chorus on --sample-rate 48000 ${soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2 &

    echo "Waiting a bit until fluidsynth is up and running..."
    ${coreutils-full}/bin/sleep 20

    echo "Connecting Keystation MIDI keyboard to fluidsynth MIDI synthesizer..."
    ${alsa-utils}/bin/aconnect -l

    # Connect MIDI keyboard (M-Audio Keystation 88es)
    ${alsa-utils}/bin/aconnect "USB Keystation:0" "FLUID Synth:0"

    # Connect MIDI controller/drum pad (AKAI LPD8 Mark2)
    ${alsa-utils}/bin/aconnect "LPD8 mk2:0" "FLUID Synth:0"

    echo "Should be connected now. Try playing something..."
  '';

in {

  # Synth user account. Don't forget to set a password with ‘passwd’.
  users.users."${synthUserName}" = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "networkmanager"
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      fluidsynth
      soundfont-fluid
    ] ++ [
      # Our custom scripts
      synthConnectionScript
    ];
  };
}
