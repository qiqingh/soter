		write_log 7 "Waiting $CHECK_SECONDS seconds (Check Interval)"
		sleep $CHECK_SECONDS &
		PID_SLEEP=$!
		wait $PID_SLEEP
		PID_SLEEP=0
	} || write_log 7 "Verbose Mode: $VERBOSE_MODE - NO Check Interval waiting"
