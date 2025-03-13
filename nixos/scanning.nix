# NixOS configuration for scanners and scanning in general.
{ config, lib, pkgs, ... } : {
  hardware = {
    # Scanner support
    sane = {
      enable = true;
      brscan4.enable = true;  # Brother DCP-7060D scanner
    };
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      simple-scan  # Simple paper scanning GUI app
    ];
  };
}
