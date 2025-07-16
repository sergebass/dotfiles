# NixOS configuration for software-defined radio (SDR) support (dongles, playback etc.)
{ config, lib, pkgs, ... } :
let
  luaRadioSource = builtins.fetchGit {
    url = "https://github.com/vsergeev/luaradio";
    rev = "dbcf8cdee0a92bb6a4757725ee5daaa35d8e2261";
  };

  luaRadioWrapper = pkgs.writeShellScriptBin "luaradio" ''
    LD_LIBRARY_PATH=${pkgs.rtl-sdr}/lib:$LD_LIBRARY_PATH
    LD_LIBRARY_PATH=${pkgs.libpulseaudio}/lib:$LD_LIBRARY_PATH
    LD_LIBRARY_PATH=${pkgs.liquid-dsp}/lib:$LD_LIBRARY_PATH
    LD_LIBRARY_PATH=${pkgs.volk}/lib:$LD_LIBRARY_PATH
    ${luaRadioSource}/luaradio "$@"
  '';

  luaRadioFMWrapper = pkgs.writeShellScriptBin "luaradio-fm" ''
    ${luaRadioWrapper}/bin/luaradio -a rx_wbfm -i rtlsdr -o pulseaudio "$@"
  '';

in {
  hardware = {
    rtl-sdr.enable = true;  # For external Software Defined Radio dongles
  };

  boot = {
    blacklistedKernelModules = [
      "dvb_usb_rtl28xxu"  # for SDR dongle - this interferes with the proper driver.
    ];
  };

  services = {
    udev = {
      enable = true;

      packages = with pkgs; [
        rtl-sdr  # For Nooelec Software Defined Radio dongle
      ];
    };
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      gnuradio  # Software Defined Radio (SDR) software
      gqrx  # Software defined radio (SDR) receiver (GUI)
      luaRadioFMWrapper  # Our custom luaradio launcher/wrapper for FM radio (defined above)
      luaRadioWrapper  # Our custom luaradio launcher/wrapper (defined above)
      luajit  # High-performance JIT compiler for Lua 5.1 (for LuaRadio)
      rtl-sdr  # Software to turn the RTL2832U into a SDR receiver
    ];
  };
}
