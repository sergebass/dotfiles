# NixOS configuration for oscilloscope support.
{ config, lib, pkgs, ... } : {
  services = {
    udev = {
      enable = true;

      packages = with pkgs; [
        openhantek6022  # Make sure we can access our USB oscilloscope properly
      ];
    };
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      openhantek6022  # Free software for Hantek and compatible (Voltcraft/Darkwire/Protek/Acetech) USB digital signal oscilloscopes
    ];
  };
}
