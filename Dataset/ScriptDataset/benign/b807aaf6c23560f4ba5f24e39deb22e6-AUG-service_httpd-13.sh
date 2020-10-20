    retVal=0
    if [ ! -f "$PID_FILE" ]; then 
	retVal=1 # Stopped
    elif [ "$(cat $PID_FILE)" == "$(pgrep lighttpd)" ]; then
	retVal=0 # Running
    else
	retVal=1 # Stopped
    fi
    return $retVal
