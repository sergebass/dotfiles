# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "zfs" ];

  # These explicit fstab mount points are only needed since we use root ZFS filesystem,
  # otherwise the order of mounts between fstab automounter and ZFS itself is unpredictable
  fileSystems."/home" = {
      device = "zroot/home";
      fsType = "zfs";
  };

  fileSystems."/home/sergii" = {
      device = "zroot/home/sergii";
      fsType = "zfs";
  };

  fileSystems."/home/sergii/works" = {
      device = "zroot/home/sergii/works";
      fsType = "zfs";
  };

  # according to the installer, ZFS requires this:
  networking.hostId = "CAFEBABE";

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    file
    wget
    curl
    tmux
    zsh
    fish
    vim
    neovim
    mc
    htop
    git
    tig
    bc
    fzf
    ripgrep-all
    xmonad-with-packages
    xmobar
    dmenu
    slock
    i3
    i3status
    i3lock
    mpd
    mpc_cli
    ncmpcpp
    mpv
    youtube-dl
    pavucontrol
    rxvt_unicode
    xfce.exo
    xfce.thunar
    firefox
    keybase
    keybase-gui
    kbfs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  services.xserver.windowManager.i3.enable = true;
  # services.xserver.windowManager.i3.package = i3-gaps;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.keybase.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sergii = {
     isNormalUser = true;
     home = "/home/sergii";
     description = "Sergii";
     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  users.extraUsers.sergii = {
     shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

