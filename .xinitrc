exec >~/.xsession-errors
shopt -s huponexit

xrandr -dpi 102

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

VBoxClient-all

export PATH=/home/jura/bin:$PATH
exec bspwm
