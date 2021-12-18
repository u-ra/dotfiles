# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=~/bin:$PATH

shopt -s histappend

alias diff='git diff --no-index'
alias egrep='egrep --color'
alias grep='grep --color'
alias ls='ls --color=auto -F'
alias ip='ip -color'
alias dots='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

if [ -f ~/.dircolors ]; then
	eval $(dircolors ~/.dircolors)
fi

[ -f ~/.bashrc-prompt ] && source ~/.bashrc-prompt || true
[ -f ~/.bashrc-work ] && source ~/.bashrc-work || true
