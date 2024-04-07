#vim: set ft=fish

function fish_hybrid_key_bindings --description \
    "also use emacs keybinding in insert mode"
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase
    bind -M insert -m default kj backward-char repaint
    bind -M replace -m default kj backward-char repaint
    bind -M default H beginning-of-line
    bind -M default L end-of-line
end
