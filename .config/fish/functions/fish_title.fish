function fish_title
    set -q argv[1]; or set argv fish
    # Example: app --arg1 --arg2  # ~/dotfiles (user@hostname)
    echo -s $argv "  # " (fish_prompt_pwd_dir_length=0 prompt_pwd) " (" $USER "@"(prompt_hostname) ")"
end
