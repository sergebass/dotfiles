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

    # The application expects CWD to be relative to the source tree
    cd ${luaRadioSource}
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

  # OpenWebRX web-based SDR receiver service can be installed via docker like so:
  # (it will use the current user's username and request password for the admin account to use)
  # After the container is started, open http://localhost:8073 in a web browser.
  #
  # docker run -e OPENWEBRX_ADMIN_USER=$USER -e OPENWEBRX_ADMIN_PASSWORD=(read -s) --tmpfs=/tmp/openwebrx --device /dev/bus/usb -p 8073:8073 -v openwebrx-settings:/var/lib/openwebrx jketterl/openwebrx:stable

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
