set pagination off
set print pretty on
set filename-display basename

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
