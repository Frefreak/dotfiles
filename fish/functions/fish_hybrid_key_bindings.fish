function __fish_cancel_commandline
    # Close the pager if it's open (#4298)
    commandline -f cancel

    set -l cmd (commandline)
    if test -n "$cmd"
        commandline -C 1000000
        if set -q fish_color_cancel
            echo -ns (set_color $fish_color_cancel) "^C" (set_color normal)
        else
            echo -ns "^C"
        end
        if command -sq tput
            # Clear to EOL (to erase any autosuggestion).
            echo -n (tput el; or tput ce)
        end
        for i in (seq (commandline -L))
            echo ""
        end
        commandline ""
        commandline -f execute
    end
end

function fish_hybrid_key_bindings --description \
    "also use emacs keybinding in insert mode"
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    bind -M insert -m default kj suppress-autosuggestion backward-char repaint
    bind -M replace -m default kj suppress-autosuggestion backward-char repaint
    bind -M default H beginning-of-line
    bind -M default L end-of-line
    bind -M insert \cP history-prefix-search-backward
    bind -M insert \cN history-prefix-search-forward
    bind --erase --preset f,1
    bind --erase --preset \cC
    bind -M insert \cC __fish_cancel_commandline

end
