# NixOS configuration for Raspberry Pi 400 implementing a software MIDI synthesizer appliance

{ config, pkgs, lib, ... }: {

  imports = [
    ../pi4-common.nix  # Configuration shared across all Pi4 systems
    ../gui-lightdm.nix  # LightDM display manager
    ../gui-xfce.nix  # XFCE X11/GUI environment
    ../keyboard-synth.nix  # MIDI keyboard talking to a software synthesizer
    ../mpd.nix
  ];

  networking = {
    hostName = "pi400";

    # The primary use case is to ensure when using ZFS that a pool isn’t imported accidentally on a wrong machine.
    hostId = "c19a013e";  # Result of running: head -c 8 /etc/machine-id
  };

  # This device is not to powerful to cope with full 4K rendering, so force it to 1080p (FullHD) for now.
  services.xserver.resolutions = [
    { x = 1920; y = 1080; }
  ];

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
