function fish_command_not_found
    if test -e $argv[1]
        set -l sz (stat $argv[1] | awk 'NR==2{print $2; exit}')
        if test $sz -lt (math "1024*1024") # 1M
            $EDITOR $argv[1]
        else
            __fish_default_command_not_found_handler $argv[1]
        end
    else
        __fish_default_command_not_found_handler $argv[1]
    end
end
