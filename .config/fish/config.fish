fish_add_path --prepend --move ~/.local/bin
fish_add_path --prepend --move ~/bin

if status is-interactive
    fish_vi_key_bindings
end

export EDITOR=nvim
export VISUAL=nvim

export LESS="-FRX"

alias g git

if test -e ~/.workspace.fish
source ~/.workspace.fish
end
