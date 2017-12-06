# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.cabal/bin:$HOME/.cargo/bin:$HOME/opt/nodejs/bin:/usr/local/bin:$PATH

if [ -d "$HOME/opt/jdk" ] ; then
    JAVA_HOME="$HOME/opt/jdk"
    PATH="$HOME/opt/jdk/bin:$PATH"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

if [ -f ~/dotfiles/scripts/h.sh ]; then
    source ~/dotfiles/scripts/h.sh
fi

export LESS="-FRX"

if [ \( "$COLORTERM" = "gnome-terminal" -o "$COLORTERM" = "Terminal" -o "$COLORTERM" = "xfce4-terminal" \) -a "$TERM" = "xterm" ] && infocmp xterm-256color >/dev/null 2>&1; then
    TERM=xterm-256color
fi

export VISUAL=vim
export EDITOR=vim

# Enable vim-style editing in the shell command prompt itself
bindkey -v
export KEYTIMEOUT=1  # 0.1 sec delay when pressing <Esc>

PS1_BASE=$'\n''%B%{$fg[cyan]%}%* %{$fg[green]%}%n%{$fg[magenta]%}@%m %{$fg[yellow]%}%0~%{$reset_color%} $(git_prompt_info)%(!.%S%{$fg[red]%}#root#%s.) ${ret_status}'

function zle-line-init zle-keymap-select {
    INSERT_PROMPT="%S%{$fg[blue]--INSERT--%}%{$reset_color%} "
    VI_PROMPT="${${KEYMAP/main/$INSERT_PROMPT}/(main|vicmd)/}"
    export PS1="$PS1_BASE${VI_PROMPT}%{$fg_bold[white]%}"
    # separate command lines with underscore characters
    #export PS1=$'${(r:$COLUMNS::_:)}\n'$PS1

    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

function zle-line-finish {
    setopt promptsubst

    export PS1="$PS1_BASE%{$reset_color%}"
    # separate command lines with underscore characters
    #export PS1=$'${(r:$COLUMNS::_:)}\n'$PS1

    zle reset-prompt

    zle accept-line
}

zle -N zle-line-finish

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

bindkey '^P' up-history
bindkey '^N' down-history

## use up/down keys for either history search or iteration
#bindkey -M vicmd '^[[A' up-line-or-search
#bindkey -M vicmd '^[[B' down-line-or-search

rmd () {
    pandoc $1 | lynx -stdin
}

source ~/.bash_aliases
