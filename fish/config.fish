function fish_greeting
end

set FISH_CONF_DIR ~/.config/fish

if status is-interactive
    source $FISH_CONF_DIR/path.fish
    source $FISH_CONF_DIR/abbr.fish
    # only need to do one time
    # source $FISH_CONF_DIR/alias.fish

    set -x EDITOR nvim
    set -x MANPAGER "nvim +Man! -c 'call clearmatches()'"
    set -g async_prompt_functions _pure_prompt_git

    fish_config theme choose Dracula
    set -x fish_key_bindings fish_hybrid_key_bindings
end
