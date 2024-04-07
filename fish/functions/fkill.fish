function fkill
    set -l pid (ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if test (count $argv) -gt 0
        kill -$argv[1] $pid
    else
        kill $pid
    end
end
