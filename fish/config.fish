function fish_greeting
end

set FISH_CONF_DIR ~/.config/fish

if status is-interactive
    source $FISH_CONF_DIR/path.fish
    source $FISH_CONF_DIR/alias.fish
    source $FISH_CONF_DIR/abbr.fish
    source $FISH_CONF_DIR/fzf.fish

    set -x EDITOR nvim
    set -x MANPAGER "nvim +Man! -c 'call clearmatches()'"

    abbr --add dotdot --regex '^\.\.+$' --function multicd
    fish_config theme choose Dracula
    set -x fish_key_bindings fish_hybrid_key_bindings
end
