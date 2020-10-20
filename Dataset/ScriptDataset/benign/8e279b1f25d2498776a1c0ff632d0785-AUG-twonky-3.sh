SUPPORT_DAEMON=$1
SUPPORT_DAEMON_WORKDIR=$2
	if [ "${SUPPORT_DAEMON}" = "" ]; then
		return 12
	fi
	if [ "${SUPPORT_DAEMON}" = "none" ]; then
		return 13
	fi

	check_support_daemon "${SUPPORT_DAEMON}"
	DSTATUS=$?
	if [ "${DSTATUS}" = "1" ]; then
		echo "${SUPPORT_DAEMON} is already running."
		return
	fi

	if [ -x "${SUPPORT_DAEMON_WORKDIR}/${SUPPORT_DAEMON}" ]; then
		echo -n "Starting ${SUPPORT_DAEMON} ... "
      		"${SUPPORT_DAEMON_WORKDIR}/${SUPPORT_DAEMON}" &
	else
		echo "Warning: support deamon ${SUPPORT_DAEMON_WORKDIR}/${SUPPORT_DAEMON} not found." 
	fi
