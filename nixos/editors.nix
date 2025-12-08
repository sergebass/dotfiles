# Nix module to describe system-wide text editor configuration
{ pkgs, ... }:
let
  systemWideVimRC = ''
    " Entry point for system-wide / default NeoVim editor configuration.
    " (Used in case ~/.config/nvim is not present)

    """ ---------------
    """ GENERAL OPTIONS
    """ ---------------

    " Use Vim settings, rather than Vi settings (much better!).
    " This must be first, because it changes other options as a side effect.
    set nocompatible

    set encoding=utf-8
    set fileencoding=utf-8

    " configure alternative keyboard layout for Latin characters with diacritics
    " (using dead characters as configured in keymap/accents.vim)
    set keymap=accents
    " but do not enable alternative layout right away (Use ^^/Ctrl+6 to switch)
    " 0 == :lmap is off and IM is off
    set iminsert=0
    " -1 == re-use the value of iminsert
    set imsearch=-1

    " even though we define our mappings in other files, we need to make sure
    " that leader and local leader keys are established well before then
    let mapleader = "-"
    let maplocalleader = "--"

    set number " enable line numbers
    set scrolloff=1 " keep at least one line visible above/below cursor
    set ruler " show the cursor position all the time
    set rulerformat=%l:%c%V

    set laststatus=2 " always display status line, even with one file being edited
    set statusline=%1*%m%r%*\ %f\ %3*%{fugitive#statusline()}%9*\ %y%{ObsessionStatus()}\ %=%{tabpagenr()}:#%n\ \"%{v:register}\ u%B/%{&fenc}/%{&ff}\ %l:%c%V\ %p%%/%L
  '';

in {

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = false;

    # Additional runtime support for plugins written in other languages.
    withPython3 = true;
    withNodeJs = true;

    configure = {
      customRC = ''
        " Reuse user configuration from home directory, if available
        if filereadable(expand("~/.config/nvim/init.vim"))
            source ~/.config/nvim/init.vim
        else
            source ${pkgs.writeText "system-wide-vimrc" systemWideVimRC}
        endif
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        # Loaded on launch
        start = [
          fugitive  # fugitive.vim: A Git wrapper so awesome, it should be illegal (https://github.com/tpope/vim-fugitive)
          fzf-vim  #  fzf + vim (https://github.com/junegunn/fzf.vim)
          vim-obsession  # obsession.vim: continuously updated session files (https://github.com/tpope/vim-obsession)
          vim-plug  # Minimalist Vim Plugin Manager (https://github.com/junegunn/vim-plug)
        ];
        # Manually loadable by calling `:packadd $plugin-name`
        opt = [
        ];
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      lua51Packages.lua  # Powerful, fast, lightweight, embeddable scripting language
      luajit  # High-performance JIT compiler for Lua 5.1
      luajitPackages.luarocks  # A package manager for Lua modules (can be used by Neovim plugins)
    ];

    variables = rec {
      EDITOR = "nvim";
      VISUAL = EDITOR;
    };
  };
}
