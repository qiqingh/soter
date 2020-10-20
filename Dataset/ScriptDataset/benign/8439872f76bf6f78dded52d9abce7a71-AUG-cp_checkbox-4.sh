    if [ ${1} -eq 0 ]; then
	echo "passed" >> ${LOGFILE}
	COUNT_PASS=`expr $COUNT_PASS + 1`
    elif [ ${1} -gt 0 ]; then
	echo "${1} *** failed ***" >> ${LOGFILE}
	COUNT_FAIL=`expr $COUNT_FAIL + 1`
    else
	echo "${1} * warning *" >> ${LOGFILE}
	COUNT_WARN=`expr $COUNT_WARN + 1`
    fi
    return 0
