# Common configuration shared by all of our NixOS systems
{ config, lib, pkgs, ... } : {

  imports = [
    ./tty.nix
    ./editors.nix
    ./users.nix
    ./version-control.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # We can use `nixos-version` to access the currently running system label.
  # Fall back on standard label/version generation if no env vars are set.
  system.nixos.version = let
    customLabel = builtins.getEnv("NIXOS_LABEL");
    customLabelPrefix = builtins.getEnv("NIXOS_LABEL_PREFIX");
  in lib.mkIf (customLabel != "" || customLabelPrefix != "") config.system.nixos.label;

  boot = {
    kernel.sysctl = {
      "kernel.sysrq" = 1;  # Enable all SysRq functions
    };

    kernelPackages = pkgs.linuxPackages;

    kernelParams = lib.mkForce [ "verbose" "nosplash" ];

    tmp.useTmpfs = true;  # Save SSD from some wear and tear

    supportedFilesystems = [
      "btrfs"
      "zfs"
      "exfat"
      "ntfs"
      "ntfs3"
    ];

    zfs = {
      forceImportRoot = false;
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
    };
  };

  security = {
    rtkit.enable = true;
  };

  networking = {
    firewall = {
      enable = true;
    };

    networkmanager = {
      enable = true;

      # Prefer our own DNS server list
      insertNameservers = [
        "9.9.9.9"  # Quad9 DNS resolver (https://en.wikipedia.org/wiki/Quad9)
        "8.8.8.8"  # Google Public DNS (https://en.wikipedia.org/wiki/Google_Public_DNS)
        "8.8.4.4"  # Google Public DNS (https://en.wikipedia.org/wiki/Google_Public_DNS)
        "1.1.1.1"  # CloudFlare DNS (https://en.wikipedia.org/wiki/1.1.1.1)
        "1.0.0.1"  # CloudFlare DNS (https://en.wikipedia.org/wiki/1.1.1.1)
      ];

      wifi.powersave = true;
    };
  };

  time.timeZone = "Canada/Eastern";

  i18n.defaultLocale = "en_CA.UTF-8";

  services = {
    openssh = {
      enable = true;
      settings.X11Forwarding = true;
    };

    timesyncd.enable = true;  # Enable NTP

    udisks2 = {
      enable = true;  # For automounting external drives in GUI file managers
      settings = {
        "udisks2.conf" = {
          defaults = {
            encryption = "luks2";
          };
          udisks2 = {
            modules = [
              "*"
            ];
            modules_load_preference = "ondemand";
          };
        };
        "mount_options.conf" = {
          defaults = {
            defaults = "noatime";
            btrfs_defaults = "compress=zstd,noatime";
          };
        };
      };
    };

    pulseaudio.enable = false;  # Use PipeWire instead

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;  # Emulate PulseAudio
      jack.enable = true;
    };
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Some programs need SUID wrappers, can be configured further
    # or are started in user sessions.
    # mtr.enable = true;
  };

  # We are OK with not completely free packages in our system
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = import ./packages-core.nix pkgs;

    localBinInPath = true;
    homeBinInPath = true;

    variables = {
      # We need this to be able to build some 3rd party packages ignoring the NixOS way temporarily
      # (e.g. for building Rust package dependencies before they can be Nixified properly)
      PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
    };
  };

  fonts = {
    enableDefaultPackages = true;  # Enable a basic set of fonts providing several styles and families and reasonable coverage of Unicode.
    packages = with pkgs; [
      # corefonts  # Microsoft's TrueType core fonts for the Web
      # glasstty-ttf  # TrueType VT220 font
      # google-fonts
      # noto-fonts  # Beautiful and free fonts for many languages
      # powerline-fonts  # Patched fonts for Powerline users
      # ubuntu-classic  # Ubuntu Classic font
      nerd-fonts.inconsolata
    ];
  };
}
