# Nix module to describe terminal/tty/console configuration
{ config, lib, pkgs, ... }:
let
  aliases = {
    v = "nvim";
    g = "git";
    x11 = "startx (which i3)";
  };

  # Default configuration options for ripgrep (rg).
  # The RIPGREP_CONFIG_PATH variable will point to this file in the Nix Store.
  ripgrepRC = ''
    # Configuration with default options for ripgrep (rg) searcher.
    # Set up RIPGREP_CONFIG_PATH variable to point to this file
    # since ripgrep does not have a default configuration file location:
    # https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file

    # Follow symbolic links
    --follow

    # Sort results by file path
    --sort=path

    # Every output line is a search result hit.
    # The number of resulting lines is the number of hits.
    --no-heading

    # Show line numbers (1-based)
    --line-number

    # Show column numbers (1-based)
    --column
  '';

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

        # Use prefix+/ to start fuzzy search
        set -g @fuzzback-bind /
      '';

      # List of plugins to install.
      plugins = with pkgs.tmuxPlugins; [
        battery
        cpu
        fuzzback  # Fuzzy search for terminal scrollback
        resurrect  # Restore tmux environment after system restart
        tmux-fzf  # Use fzf to manage your tmux work environment!
      ];

      # Additional contents of /etc/tmux.conf, to be run after sourcing plugins.
      extraConfig = ''
      '';
    };

    # Starship is a smart command prompt generator (https://starship.rs)
    starship = {
      enable = true;

      # Configuration included in starship.toml.
      # See https://starship.rs/config/#prompt for documentation.
      settings = {
        add_newline = true;
        shell = {
          disabled = false;  # Since we use multiple shells, to be aware.
          nu_indicator = "nu";
          fish_indicator = "fish";
          zsh_indicator = "zsh";
          bash_indicator = "bash";
          powershell_indicator = "powershell";
          cmd_indicator = "cmd";
          style = "gray";
        };
        username = {
          show_always = true;  # Always display user name
          format = "[$user]($style)";
          style_user = "bold green";
          style_root = "bold red";
        };
        hostname = {
          ssh_only = false;  # Always display host name
          format = "@[$ssh_symbol$hostname]($style): ";
          style = "bold purple";
        };
        directory = {
          style = "bold cyan";
          repo_root_style = "bold yellow";
          before_repo_root_style = "bold cyan";
          truncation_symbol = ".../";
          truncation_length = 0;
          truncate_to_repo = false;
          # fish_style_pwd_dir_length = 1;
        };
        git_branch = {
          style = "bold yellow";
        };
        time = {
          disabled = false;  # We do want timestamps (which are disabled by default)
          format = "[$time]($style) ";
          style = "bold white";
        };
        character = {
          success_symbol = "[=>](bold green)";
          error_symbol = "[=>](bold red)";
          vimcmd_symbol = "[N:](bold cyan)";
          vimcmd_visual_symbol = "[V:](bold yellow)";
          vimcmd_replace_symbol = "[R:](bold purple)";
          vimcmd_replace_one_symbol = "[r:](bold purple)";
        };
      };
    };

    bash = {
      shellAliases = aliases;

      loginShellInit = ''
        # Prepare for command prompt generation
        eval "$(${pkgs.starship}/bin/starship init bash)"
      '';

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

        # Prepare for command prompt generation
        ${pkgs.starship}/bin/starship init fish | source

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
      MANPAGER = "less";

      # See `man less` for the explanation of the color codes defined with `-D`:
      LESS = "-FR --use-color -Dk+M -Ds+R -Dd+226 -Du+85 -DP229.240*~ -DE200*~ -DS11.18*_ -DN238";

      # There is no default file location for ripgrep configuration,
      # we must auto-configure this variable for rg to look it up explicitly.
      RIPGREP_CONFIG_PATH = pkgs.writeText "rgrc" ripgrepRC;
    };
  };
}
