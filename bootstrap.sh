#!/bin/bash

BASE_FILES="\
	.Xresources \
	.bashrc \
	.bashrc-prompt \
	.colordiffrc \
	.compton.conf \
	.dircolors \
	.gdbinit \
	.gitconfig \
	.inputrc \
	.xinitrc \
	.pam_environment \
	"

CONFIG_DIRS="\
	bspwm \
	nvim \
	sxhkd\
	termite \
	pacaur \
	polybar \
	mpd \
	"

for F in $BASE_FILES
do
	rm -rf $F
	ln -s ~/dotfiles/$F
done

mkdir -p .config

for F in $CONFIG_DIRS
do
	rm -rf .config/$F
	ln -s ~/dotfiles/.config/$F .config/
done

cd dotfiles
git submodule update --init --recursive
cd ..
