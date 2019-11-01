# --------------------------------------------------
# Various aliases, compatible with both bash and zsh
# --------------------------------------------------

# a quicker way to go up directory trees
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# a forceful way to kick ourselves out of X (and elsewhere)
alias xlogout='pkill -u $USER'

# a quick way to start or connect to the main tmux session
alias tmx='tmux new-session -A -s 0'

alias v='NVIM_LISTEN_ADDRESS=/tmp/nvim-socket nvim'

# alias vr='NVIM_LISTEN_ADDRESS=/tmp/nvim-socket nvr'

# alias vs='vim --servername sp-server --remote-silent'
# alias gvs='gvim --servername sp-server --remote-silent'

# alias vst='vim --servername sp-server --remote-tab-silent'
# alias gvst='gvim --servername sp-server --remote-tab-silent'

alias e='emacsclient'
alias et='emacsclient -t'
alias ec='emacsclient -c'

alias g='git'

alias gsb='git status -sb'
alias gg='git grep'

# Show unstages changes (include submodules)
alias gd='git diff --submodule=diff'
# Show stages changes (include submodules)
alias gds='git diff --staged --submodule=diff'
# Show all changes (staged and not yet) (include submodules)
alias gda='git diff --submodule=diff HEAD'

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
alias gdnFIXME='grep -l FIXME $(git diff --name-only)'
# show only names of files with FIXME markers in staged files
alias gdsnFIXME='grep -l FIXME $(git diff --name-only --staged)'
# show only names of files with FIXME markers in both staged and unstaged files
alias gdanFIXME='grep -l FIXME $(git diff --name-only HEAD)'

alias gl='git log-briefly'
alias gl1='git log-briefly -1'
alias gln='git log-briefly --name-status'
alias gl1n='git log-briefly -1 --name-status'

alias gll='git log-verbosely'
alias gll1='git log-verbosely -1'
alias glln='git log-verbosely --name-status'
alias gll1n='git log-verbosely -1 --name-status'

# show only lines containing FIXME markers in the latest commit
alias gl1FIXME='grep -Hn FIXME $(git log --pretty="format:" --name-only -1) 2> /dev/null'

# show only names of files containing FIXME markers in the latest commit
alias gl1nFIXME='grep -l FIXME $(git log --pretty="format:" --name-only -1) 2> /dev/null'

# stage only non-whitespace changes (https://stackoverflow.com/a/7149602)
alias gaddnw='git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -'

alias sd="svn diff --diff-cmd $HOME/dotfiles/scripts/svnvimdiff.sh"
alias sdm='svn diff --diff-cmd meld'
alias sdv='svn diff | vim -R -'
alias sst='svn status'
alias sstq='svn status -q'

alias _sync='sync & watch -n 1 grep -e Dirty: -e Writeback: /proc/meminfo'

alias t='tig --all'

alias ag='ag -f --hidden --noheading --nobreak --nogroup --numbers --column --vimgrep'
alias rg='rg -L --hidden --no-heading -n --column'
alias rgc='rg -L --hidden --no-heading -n --column -t cpp -t c'
alias rgj='rg -L --hidden --no-heading -n --column -t java'
alias rgjs='rg -L --hidden --no-heading -n --column -t js'
alias rgts='rg -L --hidden --no-heading -n --column -t ts'
alias rgcj='rg -L --hidden --no-heading -n --column -t cpp -t c -t java'

# this is an Escape sequence to dynamically change rxvt terminal font size
alias rxvt-font-size='printf "\033]50;%s%d\007" "xft:Inconsolata:medium:antialias=true:hintstyle=hintslight:pixelsize="'

alias ubuntu-drivers='software-properties-gtk --open-tab=4'

# disassemble an object file, with source code, C++ name demangling and Intel assembly syntax
alias disasm='objdump -drwCS -Mintel'

# filters stdin, removing ANSI color escape sequences, outputs to stdout
function decolorize()
{
    perl -pe 's/\e\[[\d;]*m//g;'
}

function highlightIssues()
{
    egrep --color --ignore-case '^.*\b(fail|err|warn|problem|attention|caution).*\b|$'
}

function colorizeIssues()
{
    perl -pe 's:^.*\b(fail|err|problem).*\b|$:\033[31;1m$&\033[30;0m:gi; s:^.*\b(warn|attention|caution).*\b|$:\033[33;1m$&\033[30;0m:gi'
}

# Note that the stock Mac OS X has a version of sed different from GNU sed (with different options), this one is for GNU sed
function colorizeIssuesWithSed()
{
    sed -e 's/.*\bFAIL.*/\x1b[31;7m&\x1b[0m/i; s/.*\bERR.*/\x1b[31;7m&\x1b[0m/i; s/.*\bWARN.*/\x1b[33;7m&\x1b[0m/i'
}

function red-errors()
{
    (set -o pipefail;

    if [ -n "$ZSH_VERSION" ]; then
        setopt nomultios
    fi

    "$@" 2>&1 >&3 | sed $'s,.*,\e[31m&\e[m,' >&2) 3>&1
}

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

function yta() {
    mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}

alias mac_finder_show_hidden_files='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias mac_finder_hide_hidden_files='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

alias scan_wifi='nmcli device wifi'
