if type -q fish_add_path
    fish_add_path --prepend --move ~/.local/bin
    fish_add_path --prepend --move ~/bin
end

if status is-interactive
    fish_vi_key_bindings
end

export EDITOR=nvim
export VISUAL=nvim

export LESS="-FRX"

alias g git
alias rg "rg -L --sort path --no-heading -n --column"

if test -e ~/.workspace.fish
    source ~/.workspace.fish
end
