# NixOS configuration for Lenovo N21 Chromebook

{ config, pkgs, lib, ... }:
let
  aliases = {
    v = "nvim";
    g = "git";
    rg = "rg -L --sort path --no-heading -n --column";
  };

in {
  imports = [
    # Include the results of the hardware scan.
    # To redo hardware detection: nixos-generate-config
    /etc/nixos/hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelParams = lib.mkForce [ "verbose" "nosplash" ];

    kernel.sysctl = {
      "kernel.sysrq" = 1;  # Enable all SysRq functions
    };

    tmpOnTmpfs = true;  # Save SSD from some wear and tear
  };

  hardware = {
    pulseaudio.enable = false;  # Use PipeWire instead

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
    };
  };

  security.rtkit.enable = true;

  sound.enable = true;

  networking = {
    hostName = "n21";
    networkmanager.enable = true;

    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };

  time.timeZone = "Canada/Eastern";

  i18n.defaultLocale = "en_CA.UTF-8";

  console = {
    earlySetup = true;
    font = "ter-i16b";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  services = {
    openssh = {
      enable = true;
      forwardX11 = true;
    };

    timesyncd.enable = true;  # Enable NTP

    gpm.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;  # Emulate PulseAudio
      jack.enable = true;
    };

    xserver = {
      enable = true;

      displayManager = {
        startx.enable = false;

        lightdm = {
          enable = true;
          greeter.enable = true;
        };
      };

      desktopManager = {
        xterm.enable = false;
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock
        ];
      };

      libinput.enable = true;  # Enable touchpad support

      layout = "us,us(intl),ru,ua";

      xkbOptions = "grp:shift_caps_toggle";
    };

    blueman.enable = true;

    printing.enable = true;  # Enable CUPS

    # udev.packages = [ pkgs.rtl-sdr ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.fish;

    users.sergii = {
       isNormalUser = true;
       extraGroups = [
         "wheel"  # Enable ‘sudo’ for the user.
         "networkmanager"
         "audio"
       ];
    #   packages = with pkgs; [
    #     firefox
    #     thunderbird
    #   ];
    };
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      alacritty
      bc
      chromium
      ctags
      dmenu
      dunst
      feh
      file
      firefox
      fish
      fzf
      git
      gparted
      htop
      mc
      mpc_cli
      mpd
      mpv
      mupdf
      ncmpcpp
      neovim
      pavucontrol
      ripgrep
      rofi
      tig
      tmux
      wget
      zfs
    ];

    variables = rec {
      EDITOR = "nvim";
      VISUAL = EDITOR;
      PAGER = "less";
      LESS = "-FRX";
    };

    localBinInPath = true;
    homeBinInPath = true;
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Some programs need SUID wrappers, can be configured further
    # or are started in user sessions.
    # mtr.enable = true;

    fish = {
      enable = true;
      shellAliases = aliases;
      loginShellInit = ''
        set -U fish_greeting ""
      '';
    };
  };

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
  system.stateVersion = "22.11"; # Did you read the comment?
}
