fish_add_path --prepend --move ~/.local/bin
fish_add_path --prepend --move ~/bin

if status is-interactive
    fish_vi_key_bindings
end