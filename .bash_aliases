#alias g-st='git status -sb'

function v()
{
    vim $@
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
