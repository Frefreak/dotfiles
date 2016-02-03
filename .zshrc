#fpath=(~/.zsh/completion $fpath)
autoload -U compinit promptinit bashcompinit
compinit
promptinit
zstyle ':completion:*' menu select

setopt extended_glob

prompt fade green

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias m='make'
alias grep="egrep --color=auto"
alias gv='gvim'
alias g='git'
alias sudo='sudo '
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
alias steam-wine='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe >/dev/null 2>&1 &'

mm () { make $* 2>&1 | sed -e 's/\(.*\)\b\([Ww]arning\)\(.*\)/\1\x1b[5;1;33m\2\x1b[0m\3/i' -e 's/\(.*\)\b\([Ee]rror\)\(.*\)/\1\x1b[5;1;31m\2\x1b[0m\3/' }
compdef mm=make
ghc () { stack --verbosity slient exec -- ghc $* }
ghci () { stack --verbosity slient exec -- ghci $* }
hv () { stack --verbosity slient exec -- nvim $* }
vi () {
	if [[ ${1##*.} == "hs" || ${1##*.} == "lhs" ]];
		then stack --verbosity slient exec -- nvim $*;
		else nvim $*;
	fi
}
compdef vi=nvim


TERM=xterm-256color

SAVEHIST=1000
HISTSIZE=1000
HISTFILE=~/.history

bindkey -v
bindkey "[A" history-beginning-search-backward
bindkey "[B"  history-beginning-search-forward
bindkey "." insert-last-word

export PATH=$PATH:~/x-tools/arm-unknown-linux-gnueabi/bin/:~/bin/

. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'

. /etc/profile.d/autojump.sh

. /usr/share/doc/pkgfile/command-not-found.zsh

bashcompinit
eval "$(stack --bash-completion-script stack)"
