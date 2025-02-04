# Source bash profiles on login before launching fish
if status is-login
    exec bash -c "test -e /etc/profile && source /etc/profile;\
                  test -e $HOME/.profile && source $HOME/.profile;\
                  exec fish"
end

if type -q fish_add_path
    fish_add_path --prepend --move ~/.local/bin
    fish_add_path --prepend --move ~/bin

    fish_add_path --append --move ~/.cargo/bin
end

if status is-interactive
    fish_vi_key_bindings
end

# Uncomment this invocation to define environment variables with ANSI colors:
# source ~/.local/bin/sp-ansi-colors.sh

export EDITOR=nvim
export VISUAL=nvim

export PAGER=less
export MANPAGER=less

# See `man less` for the explanation of the color codes defined with `-D`:
export LESS="-FR --use-color -Dk+M -Ds+R -Dd+226 -Du+85 -DP229.240*~ -DE200*~ -DS11.18*_ -DN238"

export RIPGREP_CONFIG_PATH=$HOME/.rgrc

alias v nvim
alias g git

if test -e ~/.workspace.fish
    source ~/.workspace.fish
end

# Prepare for our fancy custom prompt generation
starship init fish | source
