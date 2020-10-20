   if [ -f "$PID_FILE" ] && [ -n "`$_PID`" ]; then
        if test -d "/proc/`$_PID`"; then
            return 0
        else
            rm -f $PID_FILE
            return 1
        fi
    fi
    return 1
