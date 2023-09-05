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

export EDITOR=nvim
export VISUAL=nvim

export LESS="-FRX"

alias v nvim
alias g git
alias rg "rg -L --sort path --no-heading -n --column"

if test -e ~/.workspace.fish
    source ~/.workspace.fish
end
