# NixOS configuration for Lenovo N21 Chromebook

{ config, pkgs, lib, ... }:
let
  userName = "sergii";
  userId = 1000;

  aliases = {
    v = "$VISUAL";
    g = "git";
    rg = "rg -L --sort path --no-heading -n --column";
    x11 = "startx (which i3)";
  };

  useDM = false;

in {
  imports = [
    # Include the results of the hardware scan.
    # To redo hardware detection: nixos-generate-config
    ./hardware-configuration.nix
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

    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = lib.mkForce [ "verbose" "nosplash" ];

    kernel.sysctl = {
      "kernel.sysrq" = 1;  # Enable all SysRq functions
    };

    tmp.useTmpfs = true;  # Save SSD from some wear and tear
  };

  hardware = {
    pulseaudio.enable = false;  # Use PipeWire instead

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
    };

    # Scanner support
    sane = {
      enable = true;
      brscan4.enable = true;  # Brother DCP-7060D scanner
    };
  };

  security = {
    rtkit.enable = true;

    sudo = {
      enable = true;

      # Do not require password for rebooting or powering the device off
      extraRules = [{
        commands = [
          {
            command = "${pkgs.systemd}/bin/reboot";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${pkgs.systemd}/bin/poweroff";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }];
    };
  };

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

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "9.9.9.9"
    ];

    dhcpcd = {
      # Do not use DNS server returned by a DHCP server
      extraConfig = ''
        nohook resolv.conf
      '';
    };
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
    getty = {
      greetingLine = ''\e{bold}\e{green}NixOS ${config.system.nixos.label}-\m \e{lightmagenta} \n \e{yellow} \l \e{reset}'';
    };

    openssh = {
      enable = true;
      settings.X11Forwarding = true;
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

    gvfs.enable = true;  # Mount, trash, and other functionalities

    xserver = {
      enable = true;

      displayManager = {
        startx.enable = ! useDM;

        lightdm = {
          enable = useDM;
          greeter.enable = true;
          background = /home/${userName}/.background-image;
        };
      };

      desktopManager = {
        xterm.enable = false;
        wallpaper = {
          mode = "max";
          combineScreens = false;
        };
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock
        ];
      };

      xkb = {
        layout = "us,us(intl),ru,ua";
        options = "grp:shift_caps_toggle";
      };
    };

    libinput.enable = true;  # Enable touchpad support

    blueman.enable = true;

    system-config-printer.enable = true;

    printing = {
      enable = true;  # Enable CUPS
      cups-pdf.enable = true;
      browsing = true;  # Advertise shared printers on our LAN
      drivers = with pkgs; [
        brlaser  # For Brother DCP-7060D (and others)
      ];
    };

    # Music Player Daemon
    mpd = {
      enable = true;
      startWhenNeeded = true;  # systemd feature: only start MPD service upon connection to its socket

      user = userName;  # Do not run as root

      network = {
        listenAddress = "any";  # Allow non-localhost connections
        port = 6600;  # port 6600 is the default
      };

      musicDirectory = "/home/${userName}/music";
      playlistDirectory = "/home/${userName}/music/playlists";

      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire"
        }

        audio_output {
          type "pulse"
          name "PulseAudio"
          # server "remote_server" # optional
          # sink "remote_server_sink" # optional
        }

        # Audio output for use on Linux
        audio_output {
          type "alsa"
          name "ALSA (default)"
          # device "hw:0,0" # optional
          # format "44100:16:2" # optional
          # mixer_type "hardware" # optional
          # mixer_device "default" # optional
          # mixer_control "PCM" # optional
          # mixer_index "0" # optional
        }
      '';
    };
  };

  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/${toString userId}"; # MPD will look inside this directory for the PipeWire socket.
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = true;

    defaultUserShell = pkgs.fish;

    users."${userName}" = {
      uid = userId;
      isNormalUser = true;
      extraGroups = [
        "adm"
        "audio"
        "lp"  # Printer access
        "networkmanager"
        "plugdev"  # For e.g. RTL-SDR
        "scanner"
        "video"
        "wheel"  # Enable 'sudo' for the user.
      ];
    };
  };

  # We are OK with not completely free packages in our system
  nixpkgs.config.allowUnfree = true;

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      alacritty
      alsa-utils
      bc
      chromium
      ctags
      dig
      dmenu
      dunst
      fastfetch  # Like neofetch, but much faster because written in C
      feh
      file
      findutils
      firefox
      fish
      freetube
      fzf
      git
      gparted
      htop
      kbd
      mc
      mpc_cli
      mpd
      mpv
      mupdf
      ncmpcpp
      neovim
      pavucontrol
      qrencode
      ripgrep
      rofi
      rofi-bluetooth
      rofi-calc
      rofi-file-browser
      rofi-mpd
      rofi-pulse-select
      rofi-systemd
      rofi-top
      simple-scan  # Simple paper scanning GUI app
      tig
      tmux
      tree
      wget
      xorg.xkill
      xorg.xrandr
      xorg.xsetroot
      ymuse  # GUI client for MPD
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

        if test "$(tty)" = "/dev/tty1";
          ${pkgs.fastfetch}/bin/fastfetch
        end
      '';
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
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
  system.stateVersion = "23.05"; # Did you read the comment?
}
