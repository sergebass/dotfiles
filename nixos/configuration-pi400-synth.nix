# NixOS configuration for Raspberry Pi 400 implementing a software synthesizer appliance

{ config, pkgs, lib, ... }:
let
  userName = "sergii";
  userId = 1000;

  synthUserName = "synth";

  aliases = {
    v = "$VISUAL";
    g = "git";
    rg = "rg -L --sort path --no-heading -n --column";
  };

  synthConnectionScript = with pkgs; writeShellScriptBin "synth.sh" ''
    echo "Killing any running fluidsynth instances..."
    ${killall}/bin/killall fluidsynth
    ${coreutils-full}/bin/sleep 2

    echo "Launching fluidsynth MIDI synthesizer..."
    # Use this for ALSA: --audio-driver alsa -o audio.alsa.device=default:CARD=Device
    ${fluidsynth}/bin/fluidsynth --audio-driver pulseaudio --midi-driver alsa_seq --server --no-shell --gain 1 --reverb on --chorus on --sample-rate 48000 ${soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2 &

    echo "Waiting a bit until fluidsynth is up and running..."
    ${coreutils-full}/bin/sleep 20

    echo "Connecting Keystation MIDI keyboard to fluidsynth MIDI synthesizer..."
    ${alsa-utils}/bin/aconnect -l
    ${alsa-utils}/bin/aconnect "USB Keystation:0" "FLUID Synth:0"

    echo "Should be connected now. Try playing something..."
  '';

in {
  imports = [
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = lib.mkForce [ "verbose" "nosplash" ];

    kernel.sysctl = {
      "kernel.sysrq" = 1;  # Enable all SysRq functions
    };

    tmp.useTmpfs = true;  # Save SSD from some wear and tear
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];  # Safe microSD card flash storage from extra wear
    };
  };

  networking = {
    hostName = "pi400";
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
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  security.rtkit.enable = true;

  services = {
    getty = {
      greetingLine = ''\e{bold}\e{green}NixOS ${config.system.nixos.label}-\m \e{lightmagenta} \n \e{yellow} \l \e{reset}'';
      autologinUser = "${synthUserName}";
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

    users = {
      "${synthUserName}" = {
        isNormalUser = true;
        extraGroups = [
          "audio"
        ];
      };

      "${userName}" = {
        uid = userId;
        isNormalUser = true;
        extraGroups = [
          "wheel"  # Enable ‘sudo’ for the user.
          "networkmanager"
          "audio"
        ];
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      alsa-utils
      bc
      ctags
      file
      findutils
      fish
      fluidsynth
      fzf
      git
      htop
      kbd
      killall
      links2
      mc
      mpc_cli
      mpd
      mpv
      ncmpcpp
      ncpamixer
      neovim
      pamix
      pamixer
      parted
      raspberrypi-eeprom
      ripgrep
      rsync
      soundfont-fluid
      tig
      tmux
      tree
    ] ++ [
      # Our custom scripts
      synthConnectionScript
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

        # Auto-start our MIDI keyboard -> fluidsynth link when logging in on tty1
        if test "$(tty)" = "/dev/tty1";
          ${synthConnectionScript}/bin/synth.sh
        end
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
  system.stateVersion = "23.05"; # Did you read the comment?
}
