
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
    bind -M insert \e/ history-token-search-forward
    # bind -M insert \cC __fish_cancel_commandline
    # bind -M default \cC __fish_cancel_commandline
end
