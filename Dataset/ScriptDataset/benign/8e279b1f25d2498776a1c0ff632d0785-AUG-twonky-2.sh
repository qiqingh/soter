	SUPPORT_DAEMON=$1
	if [ "${SUPPORT_DAEMON}" = "" ]; then
		return 12
	fi
	if [ "${SUPPORT_DAEMON}" = "none" ]; then
		return 13
	fi

	SD_PID=`ps --no-headers -o pid -C ${SUPPORT_DAEMON}`
	if [ "${SD_PID}" = "" ]; then
		return 0
	else
		return 1
	fi
