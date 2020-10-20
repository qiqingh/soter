	local __ERR=255
	local __CNT=0
	[ $# -ne 1 ] && write_log 12 "Error calling 'verify_dns()' - wrong number of parameters"
	write_log 7 "Verify DNS server '$1'"
	while [ $__ERR -ne 0 ]; do
		verify_host_port "$1" "53"
		__ERR=$?
		if [ $LUCI_HELPER ]; then
			return $__ERR
		elif [ $__ERR -ne 0 -a $VERBOSE_MODE -gt 1 ]; then
			write_log 4 "Verify DNS server '$1' failed - Verbose Mode: $VERBOSE_MODE - NO retry on error"
			return $__ERR
		elif [ $__ERR -ne 0 ]; then
			__CNT=$(( $__CNT + 1 ))
			[ $retry_count -gt 0 -a $__CNT -gt $retry_count ] && \
				write_log 14 "Verify DNS server '$1' failed after $retry_count retries"
			write_log 4 "Verify DNS server '$1' failed - retry $__CNT/$retry_count in $RETRY_SECONDS seconds"
			sleep $RETRY_SECONDS &
			PID_SLEEP=$!
			wait $PID_SLEEP
			PID_SLEEP=0
		fi
	done
	return 0
