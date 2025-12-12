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

  security = {
    rtkit.enable = true;
  };

  networking = {
    firewall = {
      enable = true;
    };

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    # interfaces.enp1s0.useDHCP = lib.mkDefault true;
    # interfaces.wlp3s0.useDHCP = lib.mkDefault true;
    useDHCP = lib.mkDefault true;

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
  };

  programs = {
    nix-ld.enable = true;  # Run unpatched dynamic binaries on NixOS

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
    # Core tools and packages common to all systems
    # Note that several core programs are configured in other Nix modules
    # (e.g. tmux, fish, fzf, git etc. - usually in `programs.abc` blocks)
    systemPackages = with pkgs; [
      bc  # GNU software calculator
      cmus  # Small, fast and powerful console music player for Linux and *BSD
      dig  # Domain name server utility
      file  # A program that shows the type of files
      findutils  # GNU Find Utilities, the basic directory searching utilities of the GNU operating system
      fq  # jq for binary formats
      gh  # GitHub CLI tool
      grc  # Generic text colouriser
      htop  # An interactive process viewer
      inxi  # Full featured CLI system information tool
      jq  # Lightweight and flexible command-line JSON processor
      kbd  # Linux keyboard tools and keyboard maps
      links2  # Small browser with some graphics support
      mc  # File Manager and User Shell for the GNU Project, known as Midnight Commander
      moc  # Terminal audio player designed to be powerful and easy to use
      mpc  # Minimalist command line interface to MPD
      ncdu  # Disk usage analyzer with an ncurses interface
      ncmpcpp  # Featureful ncurses based MPD client inspired by ncmpc
      ncpamixer  # Terminal mixer for PulseAudio inspired by pavucontrol
      nushell  # Modern shell written in Rust
      openpomodoro-cli  # Command-line Pomodoro tracker which uses the Open Pomodoro Format
      pamix  # Pulseaudio terminal mixer
      pamixer  # CLI utilities to control PA & PW audio levels
      psmisc  # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
      python3Minimal  # High-level dynamically-typed programming language
      ripgrep  # A utility that combines the usability of The Silver Searcher with the raw speed of grep
      rlwrap  # Readline wrapper for console programs
      rsync  # Fast incremental file transfer utility
      rtorrent  # Ncurses client for libtorrent, ideal for use with screen, tmux, or dtach
      speedtest-rs  # Command line internet speedtest tool written in rust
      sqlite-interactive  # Self-contained, serverless, zero-configuration, transactional SQL database engine
      starship  # Command prompt generator (we have it in programs.starship but it's not on PATH for some reason)
      tig  # Text-mode interface for git
      tinyxxd  # Drop-in replacement and standalone version of the hex dump utility that comes with ViM
      tree  # Command to produce a depth indented directory listing
      universal-ctags  # A maintained ctags implementation
      unzip  # An extraction utility for archives compressed in .zip format
      vifm  # Vi-like File Manager
      wget  # Tool for retrieving files using HTTP, HTTPS, and FTP
      xcd  # Colorized hexdump tool
      zip  # Compressor/archiver for creating and modifying zipfiles
    ];

    localBinInPath = true;
    homeBinInPath = true;

    variables = {
      # We need this to be able to build some 3rd party packages ignoring the NixOS way temporarily
      # (e.g. for building Rust package dependencies before they can be Nixified properly)
      PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
    };

    etc = {
      # Store the NixOS build label (reported also by nixos-version) in /etc for easy access (e.g by i3tatus etc.)
      "sergii/os-version" = {
        text = ''
          ${config.system.nixos.version}
        '';
      };
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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case we
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;
}
