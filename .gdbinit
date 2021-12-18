set print thread-events off
set pagination off
set print pretty on
set filename-display basename
set history filename ~/.cache/gdb/gdbhist
set history size 10000
set history save on

set auto-load safe-path /

handle SIGTTOU noprint nostop
handle SIGTTIN noprint nostop
handle SIG32 noprint nostop

define hook-quit
    set confirm off
end
