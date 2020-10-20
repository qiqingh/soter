    if [ -n "${TIMING_DEBUG}" ] && [ ${TIMING_DEBUG} -eq 1 ]; then
	CURR_TIME=`uptime | cut -d " " -f2`
	echo " ___ ${CURR_TIME} ___ ${1}"
    fi
    return 0
