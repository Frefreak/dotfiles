#!/usr/bin/env sh

BASHRC=$(cat <<EOF
alias n='vim -S ~/.vimrc2'
alias m='make'
alias grep='grep -P --color=auto'
alias sudo='sudo '
# alias yscl='yum --disablerepo="*" --enablerepo="*scl*"'
export PS1="\\[[32;1m\\][\\u@\\h \\w]\\$ \\[[0m\\]"
export LANG="en_US.UTF-8"
EOF
)

VIMRC=$(cat <<EOF
syntax on
set fileencodings=utf8,cp936,gb18030,big5

nnoremap H ^
nnoremap L $

inoremap kj 
cnoremap kj <C-c>

vnoremap ty "+y
nnoremap tp "+p

nnoremap ; :
nnoremap : ;

nnoremap    v   <C-V>
nnoremap <C-V>     v

vnoremap    v   <C-V>
vnoremap <C-V>     v

cmap w!! w !sudo tee % > /dev/null
nnoremap cp :e %:h<enter>
EOF
)

INPUTRC=$(cat <<EOF
# Use Vi, not Emacs, style editing
set editing-mode vi

# Show all completions as soon as I press tab, even if there's more than one
set show-all-if-ambiguous on
# Ignore case
set completion-ignore-case on

###########################################################
# Keymaps for when we're in command mode (e.g., after hitting ESC)
set keymap vi-command
Control-p: history-search-backward
Control-n: history-search-forward
H: beginning-of-line
L: end-of-line


###########################################################
# Keymaps for when we're in insert (i.e., typing stuff in) mode
set keymap vi-insert

"kj": vi-movement-mode
Control-p: history-search-backward
Control-n: history-search-forward
"\e.": yank-last-arg

EOF
)

BASHRC_B64=$(echo "$BASHRC" | base64)
VIMRC_B64=$(echo "$VIMRC" | base64)
INPUTRC_B64=$(echo "$INPUTRC" | base64)
TOTAL=$(cat << EOF
echo '$BASHRC_B64' | base64 -d >> ~/.bashrc
echo '$VIMRC_B64' | base64 -d >> ~/.vimrc2
echo '$INPUTRC_B64' | base64 -d >> ~/.inputrc
EOF
)
TOTAL_B64=$(echo "$TOTAL" | base64 | tr -d '\n')
echo "echo \"$TOTAL_B64\" | base64 -d | sh"
