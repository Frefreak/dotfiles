# {{{ oh-my-zsh
# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

fpath+=$HOME/.zsh/pure
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode urltools systemd archlinux z kubectl alias-finder web-search)

# User configuration

export PATH=$HOME/.cargo/bin:$HOME/go/bin:$HOME/bin:$HOME/.local/bin:/usr/share/bcc/tools/:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
# }}}

# {{{ custom stuffs
autoload bashcompinit
bashcompinit
setopt extended_glob
setopt no_histverify
setopt noincappendhistory
setopt nosharehistory
setopt magic_equal_subst

alias ls='ls --color=auto'
alias cm='cmake'
alias m='make'
alias n='nvim'
alias nh='stack exec -- nvim'
alias grep="grep -P --color=auto"
alias jf='journalctl -f'
alias sudo='sudo '
alias a2='aria2c'
alias pc='proxychains -q'
alias pca='proxychains -q aria2c'
alias pcg='proxychains -q git clone'
alias dol='dolphin . >& /dev/null & disown'
alias site_deploy='stack exec -- site deploy'
alias site_build='stack exec -- site build'
alias nvsmi='nvidia-smi'
alias ccmake="cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
alias yaaw="hhttp -d /usr/share/webapps/yaaw/"
mm () { make "$@" 2>&1 | sed -e 's/\(.*\)\b\([Ww]arning\)\(.*\)/\1\x1b[5;1;33m\2\x1b[0m\3/i' -e 's/\(.*\)\b\([Ee]rror\)\(.*\)/\1\x1b[5;1;31m\2\x1b[0m\3/' }
compdef mm=make
ghc () { stack --verbosity slient exec -- ghc $* }
ghci () { stack --verbosity slient exec -- ghci $* }
runhaskell () { stack --verbosity slient exec -- runhaskell $* }
ghc-pkg () { stack --verbosity slient exec -- ghc-pkg $* }
bv() {
	xxd $@ | n - -c "set ft=xxd"
}

compdef bv=xxd

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
command -v stack >/dev/null 2>&1 && eval "$(stack --bash-completion-script stack)"

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
     zsh -c "${EDITOR:-vim} $file"
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

ukill () {
  [ -n "$1" ] && sudo kill -9 `pidof $1`
}

pandoc_html() {
  fst="$1"
  shift
  pandoc --self-contained --css /home/adv_zxy/pandoc/gh-pandoc.css --mathjax -f markdown -t html \
    "$fst" -o "${fst%%.*}.html" $@
}

pandoc_html_math() {
  fst="$1"
  shift
  pandoc -s --css gh-pandoc.css --mathjax -f markdown -t html \
    "$fst" -o "${fst%%.*}.html" $@
}


# used when doing an example showcase to step to next folder
nn() {
  cd $(folder_view.py next)
}
pp() {
  cd $(folder_view.py prev)
}

pandoc_beamer() {
  pandoc -f markdown -t beamer --standalone --pdf-engine=xelatex \
    -V theme:metropolis \
    -V colortheme:beaver \
    -V mainfont="Source Sans Pro" \
    -V CJKmainfont="WenQuanYi Micro Hei" \
    -V CJKoptions="AutoFakeBold,AutoFakeSlant" \
    -V monofont="FantasqueSansMono Nerd Font Mono" "$@"
}
pandoc_pdf() {
  # fc-list :lang=zh
  pandoc -f markdown -t latex --standalone --pdf-engine=xelatex \
    -V CJKmainfont="WenQuanYi Micro Hei" \
    -V CJKoptions="AutoFakeBold,AutoFakeSlant" "$@" \
    -V monofont="FantasqueSansMono Nerd Font Mono" "$@"
}

# jq from clipboard
jqc() {
  xclip -selection clipboard -out | head -c 32768 | jq "$@"
}

export EDITOR=nvim
fpath=(/usr/share/doc/radare2/zsh /home/adv_zxy/.zfunc $fpath)
autoload -U compinit && compinit

autoload -U promptinit && promptinit
zstyle :prompt:pure:git:stash show yes
prompt pure


stfu() {
  $* >& /dev/null < /dev/null &
}

alias t='sudo /home/adv_zxy/xdp-tutorial/testenv/testenv.sh'
export PATH="$PATH:/home/adv_zxy/.cargo/bin"
export GIT_TERMINAL_PROMPT=1

use_glibc_2.25() {
  use_glibc.py $1 ~/prefix/glibc_2.25/lib ~/prefix/glibc_2.25/lib/ld-2.25.so $1.glibc_2.25
  chmod a+x $1.glibc_2.25
}

core_enable() {
  echo core | sudo tee /proc/sys/kernel/core_pattern
}

core_disable() {
  echo '|/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h' | sudo tee /proc/sys/kernel/core_pattern
}

export GOPRIVATE=git.code.oa.com
# export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
alias venv='source venv/bin/activate'

# temp
export ZSH_ALIAS_FINDER_AUTOMATIC=true

export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/share/bcc/tools
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
#}}}
