# NixOS configuration for making music (DAWs, audio production etc.)

{ config, lib, pkgs, ... }: {

  imports = [
    ./common.nix  # Common configuration shared by all of our NixOS systems
  ];

  environment = {
    systemPackages = with pkgs; [
      ardour  # Multi-track hard disk recording software
      audacity  # Sound editor with graphical UI
      coltrane  # Music calculation library/CLI
      denemo  # Music notation and composition software used with lilypond
      flac  # Library and tools for encoding and decoding the FLAC lossless audio file format
      fluidsynth  # Real-time software synthesizer based on the SoundFont 2 specifications
      guitarix  # Virtual guitar amplifier for Linux running with JACK
      gxplugins-lv2  # Set of extra lv2 plugins from the guitarix project
      hydrogen  # Advanced drum machine
      jack2.dev  # JACK audio connection kit, version 2 with jackdbus
      jackmeter  # Console jack loudness meter
      lilypond-with-fonts  # Music typesetting system
      lpd8editor  # Linux editor for the Akai LPD8
      meterbridge  # Various meters (VU, PPM, DPM, JF, SCO) for Jack Audio Connection Kit
      mi2ly  # MIDI to Lilypond converter
      musescore  # Music notation and composition software
      qjackctl  # Qt application to control the JACK sound server daemon
      qsynth  # Fluidsynth GUI
      rakarrack  # Multi-effects processor emulating a guitar effects pedalboard
      soundfont-arachno  # General MIDI-compliant bank, aimed at enhancing the realism of your MIDI files and arrangements
      soundfont-fluid  # Frank Wen's pro-quality GM/GS soundfont
      soundfont-generaluser  # General MIDI SoundFont with a low memory footprint
      soundfont-ydp-grand  # Acoustic grand piano soundfont
      sox  # Sample Rate Converter for audio
      vmpk  # Virtual MIDI Piano Keyboard
      vorbis-tools  # Extra tools for Ogg-Vorbis audio codec
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };
}
