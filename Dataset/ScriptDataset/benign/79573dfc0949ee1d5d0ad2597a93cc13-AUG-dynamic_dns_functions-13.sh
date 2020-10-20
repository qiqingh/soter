	local __TMP __HOST __PORT
	local __ERR=255
	local __CNT=0
	[ $# -ne 1 ] && write_log 12 "Error calling 'verify_proxy()' - wrong number of parameters"
	write_log 7 "Verify Proxy server 'http://$1'"
	__TMP=$(echo $1 | awk -F "@" '{print $2}')
	[ -z "$__TMP" ] && __TMP="$1"
	__HOST=$(echo $__TMP | grep -m 1 -o "$IPV6_REGEX")
	if [ -n "$__HOST" ]; then
		__PORT=$(echo $__TMP | awk -F "]:" '{print $2}')
	else
		__HOST=$(echo $__TMP | awk -F ":" '{print $1}')
		__PORT=$(echo $__TMP | awk -F ":" '{print $2}')
	fi
	[ -z "$__PORT" ] && {
		[ $LUCI_HELPER ] && return 5
		write_log 14 "Invalid Proxy server Error '5' - proxy port missing"
	}
	while [ $__ERR -gt 0 ]; do
		verify_host_port "$__HOST" "$__PORT"
		__ERR=$?
		if [ $LUCI_HELPER ]; then
			return $__ERR
		elif [ $__ERR -gt 0 -a $VERBOSE_MODE -gt 1 ]; then
			write_log 4 "Verify Proxy server '$1' failed - Verbose Mode: $VERBOSE_MODE - NO retry on error"
			return $__ERR
		elif [ $__ERR -gt 0 ]; then
			__CNT=$(( $__CNT + 1 ))
			[ $retry_count -gt 0 -a $__CNT -gt $retry_count ] && \
				write_log 14 "Verify Proxy server '$1' failed after $retry_count retries"
			write_log 4 "Verify Proxy server '$1' failed - retry $__CNT/$retry_count in $RETRY_SECONDS seconds"
			sleep $RETRY_SECONDS &
			PID_SLEEP=$!
			wait $PID_SLEEP
			PID_SLEEP=0
		fi
	done
	return 0
