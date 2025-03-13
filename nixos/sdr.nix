# NixOS configuration for software-defined radio (SDR) support (dongles, playback etc.)
{ config, lib, pkgs, ... } : {
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
      rtl-sdr  # Software to turn the RTL2832U into a SDR receiver
    ];
  };
}
