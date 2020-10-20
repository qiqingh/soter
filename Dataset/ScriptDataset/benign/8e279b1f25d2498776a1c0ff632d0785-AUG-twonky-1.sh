SUPPORT_DAEMON=$1
	if [ "${SUPPORT_DAEMON}" = "" ]; then
		return 12
	fi
	if [ "${SUPPORT_DAEMON}" = "none" ]; then
		return 13
	fi
	
	echo "Stopping ${SUPPORT_DAEMON}"
	killall ${SUPPORT_DAEMON}
