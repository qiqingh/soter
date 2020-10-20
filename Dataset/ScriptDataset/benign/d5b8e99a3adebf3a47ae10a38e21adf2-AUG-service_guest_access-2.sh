	if [ -x $GA_BIN ] ; then
		ulog guest_access status "starting $GUEST_ACCESS"
		$GA_BIN -d
		pidof $GUEST_ACCESS > $PID_FILE
		if [ $? -eq 0 ] ; then
			$PMON setproc $SERVICE_NAME $GUEST_ACCESS $PID_FILE "$SERVICE_FILE $SERVICE_NAME-restart"
		else
			ulog guest_access status "Failed to start $GUEST_ACCESS"
			rm -f $PID_FILE
		fi
	fi
