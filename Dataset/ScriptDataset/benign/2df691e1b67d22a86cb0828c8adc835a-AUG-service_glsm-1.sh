    CURRENT_LAN_STATE=`sysevent get lan-status`
    ulog glsm status "lan status changing"
    if [ "stopped" = "$CURRENT_LAN_STATE" ] ; then
        service_stop
    elif [ "started" = "$CURRENT_LAN_STATE" ] ; then
	service_start
    fi
