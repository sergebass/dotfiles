function fish_prompt --description 'sergebass-prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    if not set -q __fish_git_prompt_show_informative_status
        set -g __fish_git_prompt_show_informative_status 1
    end
    if not set -q __fish_git_prompt_hide_untrackedfiles
        set -g __fish_git_prompt_hide_untrackedfiles 1
    end
    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch magenta --bold
    end
    if not set -q __fish_git_prompt_showupstream
        set -g __fish_git_prompt_showupstream informative
    end
    if not set -q __fish_git_prompt_color_dirtystate
        set -g __fish_git_prompt_color_dirtystate blue
    end
    if not set -q __fish_git_prompt_color_stagedstate
        set -g __fish_git_prompt_color_stagedstate yellow
    end
    if not set -q __fish_git_prompt_color_invalidstate
        set -g __fish_git_prompt_color_invalidstate red
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    end
    if not set -q __fish_git_prompt_color_cleanstate
        set -g __fish_git_prompt_color_cleanstate green --bold
    end

    printf "%s%s%s " (set_color --bold bryellow --background blue) (date "+%Y-%m-%d") (set_color normal)
    printf "%s%s%s " (set_color --bold bryellow --background blue) (date "+%H:%M:%S") (set_color normal)
    printf "%s%s%s@%s " (set_color --bold brgreen) $USER (set_color purple) (prompt_hostname)
    printf "%s%s " (set_color --bold white) (tty)

    printf "\n"

    # Do not shorten path components in pwd
    set -g fish_prompt_pwd_dir_length 0

    set -l color_cwd
    set -l suffix
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd $fish_color_cwd
        end
        set suffix ' # '
    else
        set color_cwd $fish_color_cwd
        set suffix ' $ '
    end

    switch $fish_bind_mode
      case default
        set suffix_color (set_color --bold --reverse brblue)
      case insert
        set suffix_color (set_color --bold --reverse green)
      case replace_one
        set suffix_color (set_color --bold --reverse brmagenta)
      case visual
        set suffix_color (set_color --bold --reverse bryellow)
      case '*'
        set suffix_color (set_color --bold --reverse red)
    end

    printf '%s%s' (set_color --bold $color_cwd) (prompt_pwd)

    set_color normal
    printf '%s%s ' (set_color normal) (fish_vcs_prompt)

    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color --bold $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "] " "|" "$status_color" "$statusb_color" $last_pipestatus)
    echo -n $prompt_status

    printf "%s%s%s " $suffix_color $suffix (set_color normal)
end
