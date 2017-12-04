exec >~/.xsession-errors
exec 2>&1

shopt -s huponexit

export `gnome-keyring-daemon`

xinput --set-prop "ETPS/2 Elantech Touchpad" 275 1

xrandr --output HDMI1 --auto --right-of eDP1

start-pulseaudio-x11

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

if `lsusb | grep -q Griffin`; then
    setxkbmap -option altwin:swap_alt_win
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

mpd &

xautolock &

export PATH=/home/jura/bin:$PATH

rdm --isystem /usr/lib/clang/5.0.0/include &

exec bspwm
