function fg
    set -l file (ag --nobreak --noheading $argv  | fzf -0 -1 | awk -F: '{print $1"\n+"$2}')
    if test -n "$file"
        $EDITOR $file
    end
end
