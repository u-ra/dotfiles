# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ -z $DISPLAY && "$XDG_VTNR" == "1" ]] && exec startx

export EDITOR=vim
export HISTCONTROL=ignoredups
export LESS="-S -#5 -q -R -X -i"
export PAGER=less
export PATH=~/bin:$PATH

alias d='git diff' # suck it, bash completion
alias diff='colordiff -u'
alias egrep='egrep --color'
alias grep='grep --color'
alias ls='ls --color=auto -F'

alias remount='adb wait-for-device root; adb wait-for-device remount'

if [ -f ~/.dircolors ]; then
	eval $(dircolors ~/.dircolors)
fi

source ~/.bashrc-prompt

ddiff() {
	diff <(cut -d] -f2- $1 | tr -d '\r') <(cut -d] -f2- $2 | tr -d '\r') | less
}

man() {
	env LESS_TERMCAP_mb=$'\E[01;31m' \
	LESS_TERMCAP_md=$'\E[01;32m' \
	LESS_TERMCAP_me=$'\E[0m' \
	LESS_TERMCAP_se=$'\E[0m' \
	LESS_TERMCAP_so=$'\E[01;31m\E[47m' \
	LESS_TERMCAP_ue=$'\E[0m' \
	LESS_TERMCAP_us=$'\E[01;34m' \
	man "$@"
}

