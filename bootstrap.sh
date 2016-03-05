#!/bin/bash

BASE_FILES="\
	.Xresources \
	.bashrc \
	.colordiffrc \
	.dircolors \
	.gitconfig \
	.inputrc \
	.vimrc \
	.xinitrc \
	.yaourtrc \
	.pam_environment \
	"

CONFIG_DIRS="\
	bspwm \
	nvim \
	sxhkd\
	termite \
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
git submodule update --init
cd ..
