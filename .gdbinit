set print thread-events off
set pagination off
set print pretty on
set filename-display basename
set history filename ~/.gdbhist
set history save on

set auto-load safe-path /

handle SIGTTOU noprint nostop
handle SIGTTIN noprint nostop
handle SIG32 noprint nostop

define hook-quit
    set confirm off
end

define btcont
break main
run
break $arg0
while(1)
bt
c
end
end

define btcont2
break main
run
break $arg0
break $arg1
while(1)
bt
c
end
end
