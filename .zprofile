# .zprofile is the script to run when zsh is novked as a login shell

# reuse environment setup from .profile, if it exists
# (taken from https://superuser.com/a/398990)

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# if a job-specific configuration file exists, load it too
[[ -e ~/.workspace.sh ]] && emulate sh -c 'source ~/.workspace.sh'

# Uncomment this to launch tmux in a login zsh shell
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#     exec tmux new-session -A -s 0
# fi
