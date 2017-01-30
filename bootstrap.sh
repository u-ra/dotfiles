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
	.gtkrc-2.0 \
	.inputrc \
	.xinitrc \
	.pam_environment \
	"

CONFIG_DIRS="\
	bspwm \
	gtk-3.0 \
	mpd \
	nvim \
	sxhkd\
	pacaur \
	polybar \
	qt5ct \
	qterminal.org \
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
