# Nix module to describe terminal/tty/console configuration
{ config, lib, pkgs, ... }:
let
  aliases = {
    v = "nvim";
    g = "git";
    rg = "rg -L --sort path --no-heading -n --column";
    x11 = "startx (which i3)";
  };

in {
  console = {
    earlySetup = true;
    font = "ter-i16b";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  security = {
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

  services = {
    getty = {
      greetingLine = ''\e{bold}\e{green}NixOS ${config.system.nixos.label}-\m \e{lightmagenta} \n \e{yellow} \l \e{reset}'';
    };

    gpm.enable = true;  # Enable mouse in plain Linux console mode
  };

  programs = {
    tmux = {
      enable = true;
      shortcut = "Space";  # Use Ctrl+Space as the tmux prefix
      keyMode = "vi";  # Vi or Emacs style shortcuts. One of "emacs", "vi".
      clock24 = true;  # Use 24-hour clocks
      terminal = "screen-256color-bce";  # BCE = Background Color Erase
      baseIndex = 1;  # Base index for windows and panes.
      historyLimit = 100000;  # Maximum number of lines held in window history.

      # Time in milliseconds for which tmux waits after an escape is input.
      # Allows for faster key repetition.
      escapeTime = 0;

      # Additional contents of /etc/tmux.conf, to be run before sourcing plugins.
      extraConfigBeforePlugins = ''
        # Use both C-Space and M-Space to send tmux prefix (depending on the OS/GUI limitations)
        set-option -g prefix C-Space
        set-option -g prefix2 M-Space

        # Press the prefix twice to send it through to the underlying application
        unbind C-Space
        bind C-Space send-prefix
        unbind M-Space
        bind M-Space send-prefix -2

        # Navigate between current and previous windows or panes
        unbind Tab
        bind Tab last-window
        unbind M-Tab
        bind M-Tab last-pane
      '';

      # List of plugins to install.
      plugins = with pkgs.tmuxPlugins; [
        battery
        cpu
        resurrect  # Restore tmux environment after system restart
      ];

      # Additional contents of /etc/tmux.conf, to be run after sourcing plugins.
      extraConfig = ''
      '';
    };

    # Starship is a smart command prompt generator (https://starship.rs)
    starship = {
      enable = true;
    };

    bash = {
      shellAliases = aliases;

      undistractMe = {
        enable = true;

        # Number of seconds it would take for a command to be considered long-running.
        timeout = 30;

        # Whether to enable notification sounds when long-running terminal commands complete.
        playSound = true;
      };
    };

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

    fzf = {
      fuzzyCompletion = true;
      keybindings = true;
    };
  };

  environment = {
    variables = {
      PAGER = "less";
      LESS = "-FRX";
    };
  };
}
