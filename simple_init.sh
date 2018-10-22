#!/usr/bin/env sh

BASHRC=$(cat <<EOF
alias n='vim -S ~/.vimrc2'
alias m='make'
alias grep='grep -P --color=auto'
alias sudo='sudo '
# alias yscl='yum --disablerepo="*" --enablerepo="*scl*"'
export PS1="\\[[32;1m\\][\\u@\\h \\w]\\$ \\[[0m\\]"
export PATH=/opt/rh/rh-python36/root/usr/bin:\$PATH
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
EOF
)
BASHRC_B64=$(echo "$BASHRC" | base64)
VIMRC_B64=$(echo "$VIMRC" | base64)
TOTAL=$(cat << EOF
echo '$BASHRC_B64' | base64 -d >> ~/.bashrc
echo '$VIMRC_B64' | base64 -d >> ~/.vimrc2
EOF
)
TOTAL_B64=$(echo "$TOTAL" | base64 | tr -d '\n')
echo "echo \"$TOTAL_B64\" | base64 -d | sh"
