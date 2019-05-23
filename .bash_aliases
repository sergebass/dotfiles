alias v='NVIM_LISTEN_ADDRESS=/tmp/nvim-socket nvim'

# alias vr='NVIM_LISTEN_ADDRESS=/tmp/nvim-socket nvr'

# alias vs='vim --servername sp-server --remote-silent'
# alias gvs='gvim --servername sp-server --remote-silent'

# alias vst='vim --servername sp-server --remote-tab-silent'
# alias gvst='gvim --servername sp-server --remote-tab-silent'

alias e='emacsclient'
alias et='emacsclient -t'
alias ec='emacsclient -c'

alias gsb='git status -sb'
alias gg='git grep'

# Show unstages changes
alias gd='git diff'
# Show stages changes
alias gds='git diff --staged'
# Show all changes (staged and not yet)
alias gda='git diff HEAD'

# show only names of changed files: in working directory
alias gdN='git diff --name-only'
# show only names of changed files: in staged area
alias gdsN='git diff --name-only --staged'
# show only names of changed files: both staged and unstaged
alias gdaN='git diff --name-only HEAD'

# invoke editor with all of the unstaged files
alias gdE='$EDITOR $(git diff --name-only)'
# invoke editor with all of the staged files
alias gdsE='$EDITOR $(git diff --name-only --staged)'
# invoke editor with all of the staged and unstaged files
alias gdaE='$EDITOR $(git diff --name-only HEAD)'

# show FIXME markers in unstaged files
alias gdFIXME='grep -Hn FIXME $(git diff --name-only)'
# show FIXME markers in staged files
alias gdsFIXME='grep -Hn FIXME $(git diff --name-only --staged)'
# show FIXME markers in both staged and unstaged files
alias gdaFIXME='grep -Hn FIXME $(git diff --name-only HEAD)'

# show only names of files with FIXME markers in unstaged files
alias gdFIXMEN='grep -l FIXME $(git diff --name-only)'
# show only names of files with FIXME markers in staged files
alias gdsFIXMEN='grep -l FIXME $(git diff --name-only --staged)'
# show only names of files with FIXME markers in both staged and unstaged files
alias gdaFIXMEN='grep -l FIXME $(git diff --name-only HEAD)'

# show only the list of file names in the latest commit
alias gl1N='git log --pretty="format:" --name-only -1'

# show only lines containing FIXME markers in the latest commit
alias gl1FIXME='grep -Hn FIXME $(git log --pretty="format:" --name-only -1)'

# show only names of files containing FIXME markers in the latest commit
alias gl1FIXMEN='grep -l FIXME $(git log --pretty="format:" --name-only -1)'

# stage only non-whitespace changes (https://stackoverflow.com/a/7149602)
alias gaddnw='git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -'

alias sd='svn diff | vim -R -'
alias sst='svn status'

alias _sync='sync & watch -n 1 grep -e Dirty: -e Writeback: /proc/meminfo'

alias t='tig --all'

alias ag='ag -f --hidden --noheading --nobreak --nogroup --numbers --column --vimgrep'
alias rg='rg -L --hidden --no-heading -n --column'

# this is an Escape sequence to dynamically change rxvt terminal font size
alias rxvt-font-size='printf "\033]50;%s%d\007" "xft:Inconsolata:medium:antialias=true:hintstyle=hintslight:pixelsize="'

# cd to selected directory, specified on the command line or chosen from the fzf list
# start directory lookup from the current directory and ignore hidden directories (starting with dot)
fzcd() {
  local dir
  dir=$(find -L . -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf -0 -1 +m -q "$1") &&
  cd "$dir"
}

# cd to selected directory, specified on the command line or chosen from the fzf list
# start directory lookup from the current directory and include hidden directories (starting with dot)
fzcda() {
  local dir
  dir=$(find -L . -path '\*' -prune -o -type d -print 2> /dev/null | fzf -0 -1 +m -q "$1") &&
  cd "$dir"
}

# cd to selected directory, specified on the command line or chosen from the fzf list
# start directory lookup from the user's home directory
fzcdh() {
  local dir
  dir=$(find -L ~ -type d -print 2> /dev/null | fzf -0 -1 +m -q "$1") &&
  cd "$dir"
}

# cd to selected directory, specified on the command line or chosen from the fzf list
# start directory lookup from the root directory
fzcdr() {
  local dir
  dir=$(find -L / -type d -print 2> /dev/null | fzf -0 -1 +m -q "$1") &&
  cd "$dir"
}

# cd into the directory of the selected file, specified on the command line or chosen from the fzf list
fzcdf() {
   local file
   local dir
   file=$(fzf -0 -1 +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# fze [FUZZY PATTERNS...]
# fuzzy-find a file or files and edit it/them in vim/neovim
fze() {
   local files
   files=$(find -L . -type f -print 2> /dev/null | fzf -0 -1 --print0 -m -q "$1" | tr '\000' ' ') && $EDITOR -c "args $files | tab all"
}

# fuzzy grep using ag; open results via default editor at a specific line numbers and columns
fzag() {
  local files
  files=$(ag -f --hidden --noheading --nobreak --nogroup --numbers --column  $@ | fzf -0 -1 -m | awk -F: '{print $1, $2, $3}' | tr ' ' ':' | tr '\n' ' ')

  if [[ -n $files ]]
  then
      $EDITOR -c "args $files | tab all"
  fi
}

# fuzzy grep using rg; open results via default editor at a specific line numbers and columns
fzrg() {
  local files
  files=$(rg -L --hidden --no-heading -n --column $@ | fzf -0 -1 -m | awk -F: '{print $1, $2, $3}' | tr ' ' ':' | tr '\n' ' ')

  if [[ -n $files ]]
  then
      $EDITOR -c "args $files | tab all"
  fi
}

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
