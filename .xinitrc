exec >~/.xsession-errors
shopt -s huponexit

export PATH=/home/jura/bin:$PATH
exec bspwm
