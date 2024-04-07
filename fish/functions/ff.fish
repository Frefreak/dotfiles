function ff
    set -l files (fzf-tmux --query=$argv[1] --multi --select-1 --exit-0)
    if test -n "$files"
        $EDITOR $files
    end
end
