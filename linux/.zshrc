# {{{ oh-my-zsh

ZSH=/usr/share/oh-my-zsh/
fpath+=$HOME/.zsh/pure
ZSH_THEME=""
DISABLE_AUTO_UPDATE="true"
plugins=(git vi-mode urltools systemd archlinux z kubectl alias-finder web-search)
source $ZSH/oh-my-zsh.sh
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

fpath=(/usr/share/doc/radare2/zsh /home/$USER/.zfunc $fpath)
autoload -U compinit && compinit
autoload -U promptinit && promptinit
autoload bashcompinit && bashcompinit

# }}}

# {{{ User configuration
export PATH=$HOME/.cargo/bin:$HOME/go/bin:$HOME/bin:$HOME/.local/bin:/usr/share/bcc/tools/:$PATH

setopt extended_glob
setopt no_histverify
setopt noincappendhistory
setopt nosharehistory
setopt magic_equal_subst

alias ls='ls --color=auto'
alias cm='cmake'
alias m='make'
alias n='nvim'
alias grep="grep -P --color=auto"
alias jf='journalctl -f'
alias sudo='sudo '
alias a2='aria2c'
alias dol='dolphin . >& /dev/null & disown'
alias nvsmi='nvidia-smi'
alias ccmake="cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
alias yaaw="hhttp -d /usr/share/webapps/yaaw/"
alias virsh='virsh -c qemu:///system'
alias checksec='pwn checksec'
alias hv=hexyl

mm () { make "$@" 2>&1 | sed -e 's/\(.*\)\b\([Ww]arning\)\(.*\)/\1\x1b[5;1;33m\2\x1b[0m\3/i' -e 's/\(.*\)\b\([Ee]rror\)\(.*\)/\1\x1b[5;1;31m\2\x1b[0m\3/' }
compdef mm=make

SAVEHIST=1000
HISTSIZE=1000
HISTFILE=~/.history

bindkey -v
bindkey "" history-beginning-search-backward
bindkey ""  history-beginning-search-forward
bindkey "." insert-last-word
insert-last-word-forward() zle insert-last-word 1
zle -N insert-last-word-forward
bindkey ';' insert-last-word-forward

bindkey -M viins 'kj' vi-cmd-mode
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line

export MANPAGER="nvim +Man! -c 'call clearmatches()'"
export VIMRC="$HOME/.config/nvim/init.vim"
export GPG_TTY=$(tty)

[[ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]] && . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -d /usr/share/zsh-syntax-highlighting ]] && . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
command -v pandoc >/dev/null 2>&1 && eval "$(pandoc --bash-completion)"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=white,underline'

## fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden'
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

vg() {
  local file

  file=$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1 " +" $2}')

  if [[ -n $file ]]
  then
     zsh -c "${EDITOR:-nvim} $file"
  fi
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

# unique without sorting
uniqNoSort() {
	perl -ne 'print unless $seen{$_}++'
}

fo() {
  n -c "lua require('telescope.builtin').oldfiles()"
}

ff() {
  n -c "lua require('telescope.builtin').find_files()"
}

magnet-info() {
  hash=$(echo "$1" | grep -oP "(?<=btih:).*?(?=&)")
  echo "Magnet hash: $hash"
  aria2c --bt-metadata-only=true --bt-save-metadata=true -q "$1"
  aria2c "$hash.torrent" -S
}

# urban dictionary
ud() {
  curl http://api.urbandictionary.com/v0/define\?term\="$1" 2>/dev/null | \
    jq ".list | .[] | .definition" |& python -u -c \
    "print(__import__('sys').stdin.buffer.read().decode('unicode_escape'))"
}

pandoc_html() {
  fst="$1"
  shift
  pandoc --self-contained --css /home/$USER/pandoc/gh-pandoc.css --mathjax -f markdown -t html \
    "$fst" -o "${fst%%.*}.html" $@
}

pandoc_html_math() {
  fst="$1"
  shift
  pandoc -s --css gh-pandoc.css --mathjax -f markdown -t html \
    "$fst" -o "${fst%%.*}.html" $@
}

pandoc_beamer() {
  pandoc -f markdown -t beamer --standalone --pdf-engine=xelatex \
    -V theme:metropolis \
    -V colortheme:beaver \
    -V mainfont="Source Sans Pro" \
    -V CJKmainfont="Source Han Sans" \
    -V CJKoptions="AutoFakeBold,AutoFakeSlant" \
    -V monofont="FantasqueSansMono Nerd Font Mono" "$@"
}
pandoc_pdf() {
  # fc-list :lang=zh
  pandoc -f markdown -t latex --standalone --pdf-engine=xelatex \
    -V CJKmainfont="Source Han Sans" \
    -V CJKoptions="AutoFakeBold,AutoFakeSlant" "$@" \
    -V monofont="FantasqueSansMono Nerd Font Mono" "$@"
}

# jq from clipboard
jqc() {
  xclip -selection clipboard -out | head -c 32768 | jq "$@"
}

export EDITOR=nvim

stfu() {
  $* >& /dev/null < /dev/null &
}

alias t="sudo /home/$USER/xdp-tutorial/testenv/testenv.sh"
export GIT_TERMINAL_PROMPT=1
zstyle :prompt:pure:git:stash show yes
prompt pure

core_enable() {
  echo core | sudo tee /proc/sys/kernel/core_pattern
}

core_disable() {
  echo '|/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h' | sudo tee /proc/sys/kernel/core_pattern
}

# export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
alias venv='source venv/bin/activate'

# temp
export ZSH_ALIAS_FINDER_AUTOMATIC=true

[[ -f ~/.work_stuffs.zsh ]] && source ~/.work_stuffs.zsh
#}}}
