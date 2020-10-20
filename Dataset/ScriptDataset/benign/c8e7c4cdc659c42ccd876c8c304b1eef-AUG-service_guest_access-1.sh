	if [ -x $GA_BIN ] ; then
		pidof $GUEST_ACCESS > /dev/null
		if [ $? -eq 0  ] ; then
			ulog guest_access status "stopping $GUEST_ACCESS"
			$PMON unsetproc $SERVICE_NAME
			killall $GUEST_ACCESS > /dev/null 2>&1
			rm -f $PID_FILE
		fi
	fi
