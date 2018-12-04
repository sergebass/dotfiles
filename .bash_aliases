alias v='NVIM_LISTEN_ADDRESS=/tmp/nvim-socket nvim'
alias vr='NVIM_LISTEN_ADDRESS=/tmp/nvim-socket nvr'

alias vs='vim --servername sp-server --remote-silent'
alias gvs='gvim --servername sp-server --remote-silent'

alias vst='vim --servername sp-server --remote-tab-silent'
alias gvst='gvim --servername sp-server --remote-tab-silent'

alias e='emacsclient'
alias et='emacsclient -t'
alias ec='emacsclient -c'

alias gsb='git status -sb'
alias agj='ag --type=java'

alias gg='git grep'
alias gda='git diff HEAD'

# stage only non-whitespace changes (https://stackoverflow.com/a/7149602)
alias gaddnw='git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -'

alias rg='rg --no-heading -n'

alias t='tig --all'

# this is an Escape sequence to dynamically change rxvt terminal font size
alias rxvt-font-size='printf "\033]50;%s%d\007" "xft:Inconsolata:medium:antialias=true:hintstyle=hintslight:pixelsize="'

function svn-blame() {
    svn ann -v "$@" | less
}

function f()
{
    find -name \*.c\* -o -name \*.h\* -o -name \*.py -o -name \*.sh -o -name \*.pl -o -name \*.pro | xargs -n 1 grep --color=always -Hn "$@"
}

function fr()
{
    find -name \*.c\* -o -name \*.h\* -o -name \*.py -o -name \*.sh -o -name \*.pl -o -name \*.pro | xargs -n 1 grep --color=none -Hn "$@"
}

function c()
{
    exec $@ 2>&1 | sed -e 's/.*\bFAIL.*/\x1b[31;7m&\x1b[0m/i' -e 's/.*\bERR.*/\x1b[31;7m&\x1b[0m/i' -e 's/.*\bWARN.*/\x1b[33;7m&\x1b[0m/i'
}

function red-errors()
{
    (set -o pipefail;

    if [ -n "$ZSH_VERSION" ]; then
        setopt nomultios
    fi

    "$@" 2>&1 >&3 | sed $'s,.*,\e[31m&\e[m,' >&2) 3>&1
}

function qm()
{
#    make $@ 2>&1 | sed -e 's/.*\bFAIL.*/\x1b[31;7m&\x1b[0m/i' -e 's/.*\bERR.*/\x1b[31;7m&\x1b[0m/i' -e 's/.*\bWARN.*/\x1b[33;7m&\x1b[0m/i'
    qmake && make $@ 2> >(~/repos/rha-acquisition/libannidis/python/annidis/logger/colorizer.py)
}

function m()
{
#    make $@ 2>&1 | sed -e 's/.*\bFAIL.*/\x1b[31;7m&\x1b[0m/i' -e 's/.*\bERR.*/\x1b[31;7m&\x1b[0m/i' -e 's/.*\bWARN.*/\x1b[33;7m&\x1b[0m/i'
    make $@ 2> >(~/repos/rha-acquisition/libannidis/python/annidis/logger/colorizer.py)
}

function git-find-file()
{
    for branch in $(git rev-list --all)
    do
        if (git ls-tree -r --name-only $branch | grep --quiet "$1")
        then
            echo $branch
        fi
    done
}

function g-status()
{
    git status -sb && git submodule foreach git status -sb
}

function g-diff()
{
    git diff && git submodule foreach --recursive git diff
}

function g-graph()
{
    git log --all --graph --pretty=format:'%C(bold cyan)%h%Creset -%C(bold yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset'
}

function check-previous-result()
{
#FIXME this should provide a red marker if the previous command failed (exit code is not 0)
    echo "[^$?] "
}

function clean-all()
{
    make clean
    find -name \*.o -exec rm {} \;
    find -name \*.a -exec rm {} \;
    find -name moc_\* -exec rm {} \;
    find -name ui_\* -exec rm {} \;
    ccache -C
}

function rmd () {
    pandoc $1 | lynx -stdin
}
