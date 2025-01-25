# Nix module to configure system-wide version control tools
{ config, lib, pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      lfs.enable = true;  # Large File Support

      config = [
        {
          user.name = "Sergii Perynskyi";
        }
        {
          init = {
            defaultBranch = "main";
          };
        }
        {
          alias = {
            list-aliases = "config --get-regexp 'alias.*'";

            # invoke text editor on global git configuration file (most likely this one)
            edit-config = "config --global --edit";

            sb = "status -sb";

            # list untracked files only (without any markers, for scripting)
            lsu = "ls-files --others --exclude-standard";
            # list untracked files only (without any markers, for scripting), NUL-delimited
            lsu0 = "ls-files --others --exclude-standard -z";

            stat = "diff --stat";

            sl = "stash list";
            ss = "stash save";
            sp = "stash pop";
            sa = "stash apply";

            g = "grep --color -I -n";

            log-briefly = "log --date=iso --decorate=full --color --pretty=format:\"%C(green)%h\\ %ai\\ %Creset\\%s\\ %C(cyan\\ bold)(%an)%C(yellow\\ bold)%d\"";
            log-verbosely = "log --date=iso --decorate=full --color --pretty=format:\"%C(green\\ bold\\ reverse)%H\\ %C(yellow)%d\\ %n%C(cyan\\ bold)[%ai]\\ \\ %an\\ <%ae>%n%C(magenta\\ bold)[%ci]\\ \\ %cn\\ <%ce>%n%n%C(yellow\\ bold)%B%Creset\"";

            l = "!git log-briefly";
            ls = "!git l --stat";
            ll = "!git log-verbosely";
            lls = "!git ll --stat";

            l1 = "!git l -1";
            ls1 = "!git ls -1";
            ll1 = "!git ll -1";
            lls1 = "!git lls -1";

            log-graph = "!git log-briefly --graph";
            log-stat = "!git log-briefly --numstat";

            log-files-only = "show --pretty=\"\" --name-only";

            search-text = "!git log-verbosely --stat --all --remotes -S";
            search-text-regexp = "!git log-verbosely --stat --all --remotes -G";

            s = "!git search-text";

            search-file = "log --stat --all --remotes --follow --";
            search-file-diff = "log -p --stat --all --remotes --follow --";

            sf = "!git search-file";

            # show only the list of file names in the latest commit
            ln1 = "log --pretty=\"format:\" --name-only -1";

            # show only names of changed files: in working directory
            dn = "diff --name-only";
            # show only names of changed files: in staged area
            dns = "diff --name-only --staged";
            # show only names of changed files: both staged and unstaged
            dna = "diff --name-only HEAD";

            # diff unstaged files (including submodules)
            d = "diff --submodule=diff";
            # diff staged files (including submodules)
            ds = "diff --submodule=diff --staged";
            # diff all changes (staged and not yet) (including submodules)
            da = "diff --submodule=diff HEAD";

            # diff unstaged files (including submodules) using difftool
            dt = "difftool -t nvim --submodule=diff";
            # diff staged files (including submodules) using difftool
            dts = "difftool -t nvim --submodule=diff --staged";
            # diff all changes (staged and not yet) (including submodules) using difftool
            dta = "difftool -t nvim --submodule=diff HEAD";

            conflicts-show = "diff --name-only --diff-filter=U";
            conflicts-check = "diff --check";
            conflicts-merge = "mergetool -t nvim";

            co = "checkout";
            cob = "checkout -b";

            fetch-pr = "!f() { git fetch $1 pull/$2/head && git checkout FETCH_HEAD; }; f";

            bn = "!git rev-parse --abbrev-ref HEAD";
            bu = "branch --set-upstream-to";
            bd = "branch --delete";

            ri = "rebase --interactive";
            ra = "rebase --abort";
            rc = "rebase --continue";

            ap = "add --patch";
            au = "add --update";
            aup = "add --update --patch";

            # add and commit in a single step
            ac = "!git add -u && git commit -ev";

            c = "commit -ev";
            cm = "commit -evm";

            commit-to-squash = "commit -evm 'FIXME squash this'";
            csq = "!git commit-to-squash";

            commit-fix = "commit --amend --verbose";
            commit-fix-author = "commit --amend --verbose --reset-author";

            # undo the latest commit
            u1 = "reset --hard HEAD~1";

            # unstage files, unstage all without arguments
            u = "reset HEAD";

            # revert a file
            rv = "checkout --";

            pf = "push --force-with-lease";
            pu = "push --set-upstream";

            last-tag = "describe --tags --abbrev=0";

            last-branches = "for-each-ref --sort=-committerdate refs/heads --format='%(committerdate:short) %(refname:short)'";

            backup = "!git diff @{upstream} > ~/git-backup-$(git rev-parse --abbrev-ref HEAD)-$(date \"+%Y%m%d-%H%M%S\").patch";

            commits-by-author = "shortlog -s -n --all --no-merges";
          };
        }
      ];
    };
  };
}
