        SUPPORT_DAEMON=$1
        if [ "${SUPPORT_DAEMON}" = "" ]; then
                return 12
        fi
	if [ "${SUPPORT_DAEMON}" = "none" ]; then
		return 13
	fi

	check_support_daemon "${SUPPORT_DAEMON}"
	DSTATUS=$?
	if [ "${DSTATUS}" = "0" ]; then
		echo "${SUPPORT_DAEMON} is not running."
		return;
	fi
	if [ "${DSTATUS}" = "1" ]; then
		echo "${SUPPORT_DAEMON} is running."
		return;
	fi
	echo "Error checking status of ${SUPPORT_DAEMON}"
