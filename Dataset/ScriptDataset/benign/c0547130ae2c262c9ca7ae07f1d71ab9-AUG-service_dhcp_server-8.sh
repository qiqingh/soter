    if [ -f $PID_FILE ]; then
        kill -HUP `cat $PID_FILE`
    fi
