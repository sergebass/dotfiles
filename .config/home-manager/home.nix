# Nix module for managing user-level configuration via Home Manager
# https://nix-community.github.io/home-manager
{ config, pkgs, ... }:

rec {
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "sergii";
  home.homeDirectory = "/home/${home.username}";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # hello

    # It is sometimes useful to fine-tune packages, for example, by applying
    # overrides. You can do that directly here, just don't forget the
    # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles.
  # The primary way to manage plain files is through 'home.file'.
  home.file = let
    # Provide a way to auto-generate symlinks to our _mutable_ dotfiles directory
    # (as opposed to copying source files to the Nix store and keeping them read-only).
    dotfilesRoot = ../../../dotfiles;

    # This function uses a Path type argument, not a string.
    # e.g. ".config/test" = symlink ../../../dotfiles/test;
    symlink = sourcePath: {
      source = config.lib.file.mkOutOfStoreSymlink (toString sourcePath);
    };

    symlinkDotfiles = sourcePath: {
      source = config.lib.file.mkOutOfStoreSymlink "${toString dotfilesRoot}/${sourcePath}";
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sergii/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
