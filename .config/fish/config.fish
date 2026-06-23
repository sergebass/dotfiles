# Source bash profiles on login before launching fish
if status is-login
    exec bash -c "test -e /etc/profile && source /etc/profile;\
                  test -e $HOME/.profile && source $HOME/.profile;\
                  exec fish"
end

if type -q fish_add_path

    fish_add_path --prepend --move $HOME/opt/node/bin
    fish_add_path --prepend --move $HOME/.cargo/bin
    fish_add_path --prepend --move $HOME/.local/bin
    fish_add_path --prepend --move $HOME/bin

else  # For older fish versions

    set --global --export --prepend PATH $HOME/opt/node/bin
    set --global --export --prepend PATH $HOME/.cargo/bin
    set --global --export --prepend PATH $HOME/.local/bin
    set --global --export --prepend PATH $HOME/bin
end

if status is-interactive
    fish_vi_key_bindings
end

# Uncomment this invocation to define environment variables with ANSI colors:
# source ~/.local/bin/sp-ansi-colors.sh

export EDITOR=nvim
export VISUAL=nvim

export PAGER=bat
export MANPAGER=less

# See `man less` for the explanation of the color codes defined with `-D`:
# export LESS="-FR --use-color -Dk+M -Ds+R -Dd+226 -Du+85 -DP229.240*~ -DE200*~ -DS11.18*_ -DN238"
export LESS="-FR"

export RIPGREP_CONFIG_PATH=$HOME/.rgrc

# SSH operation prevents neovim from using some local terminal features, so disable them when running in SSH sessions.
if test -n "$SSH_CLIENT" -o -n "$SSH_TTY"
    export NVIM_NOTTYFAST=1
end

# Some useful aliases
alias v "nvim"
alias V "nvim -R"

alias l "lsd"
alias la "lsd -a"
alias ll "lsd -l"
alias lla "lsd -la"
alias lt "lsd --tree"
alias llt "lsd -l --tree"

alias g "git"
alias p "mpv --term-title='♪ \${metadata/icy-title:---}'"

if test -e ~/.workspace.fish
    source ~/.workspace.fish
end

# Prepare for our fancy custom prompt generation
starship init fish | source
