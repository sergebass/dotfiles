# Nix module for user registration and user-specific configuration
{ config, lib, pkgs, ... }:
let
  userName = "sergii";
  userId = 1000;

in {
  imports = [
    <home-manager/nixos>  # User-level configuration managed by Home Manager (https://nix-community.github.io/home-manager)
  ];

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
        "dialout"  # to access /dev/ttyACM ports (e.g. Arduino)
        "lp"  # Printer access
        "networkmanager"
        "plugdev"  # For e.g. RTL-SDR
        "scanner"
        "video"
        "wheel"  # Enable 'sudo' for the user.
      ];
    };
  };

  home-manager = {
    # Use the global pkgs that is configured via the system level nixpkgs options.
    # This saves an extra Nixpkgs evaluation, adds consistency, and removes the dependency on NIX_PATH,
    # which is otherwise used for importing Nixpkgs.
    # useGlobalPkgs = true;

    users = rec {
      "${userName}" = { config, lib, pkgs, ... }: {
        home.packages = with pkgs; [
        ];

        home.file = let
          # Provide a way to auto-generate symlinks to our _mutable_ dotfiles directory
          # (as opposed to copying source files to the Nix store and keeping them read-only).
          dotfilesDirName = "dotfiles";

          symlinkDotfiles = dotfilesSubtreePath: {
            source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${dotfilesDirName}/${dotfilesSubtreePath}";
          };

          # This function uses a Path type argument, not a string.
          # e.g. ".config/test" = symlink ../../../dotfiles/test;
          symlinkPath = sourcePath: {
            source = config.lib.file.mkOutOfStoreSymlink (toString sourcePath);
          };

        in {

          # Auto-generate symlinks to _mutable_ dotfiles repo checkout
          # Note that we deliberately skip the .config/home-manager symlink
          # since having it in this list produces an error.
          # This is one symlink we need to create manually with `ln -s` ourselves.
          ".config/fish" = symlinkDotfiles ".config/fish";
          ".config/mc" = symlinkDotfiles ".config/mc";
          ".config/nushell" = symlinkDotfiles ".config/nushell";
          ".config/nvim" = symlinkDotfiles ".config/nvim";
          ".config/tmux" = symlinkDotfiles ".config/tmux";
          ".vim" = symlinkDotfiles ".vim";

          # Building this configuration will create a copy of 'dotfiles/screenrc' in
          # the Nix store. Activating the configuration will then make '~/.screenrc' a
          # symlink to the Nix store copy.
          # ".screenrc".source = dotfiles/screenrc;

          # You can also set the file content immediately.
          # ".gradle/gradle.properties".text = ''
          #   org.gradle.console=verbose
          #   org.gradle.daemon.idletimeout=3600000
          # '';
        };

        # The state version is required and should stay at the version you originally installed.
        home.stateVersion = "24.11";
      };
    };
  };
}
