	local __URL="$1"
	local __ERR=0
	local __CNT=0
	local __PROG  __RUNPROG
	[ $# -ne 1 ] && write_log 12 "Error in 'do_transfer()' - wrong number of parameters"
	if [ -n "$(which wget-ssl)" -a $USE_CURL -eq 0 ]; then
		__PROG="$(which wget-ssl) -nv -t 1 -O $DATFILE -o $ERRFILE"
		if [ -n "$bind_network" ]; then
			local __BINDIP
			[ $use_ipv6 -eq 0 ] && __RUNPROG="network_get_ipaddr" || __RUNPROG="network_get_ipaddr6"
			eval "$__RUNPROG __BINDIP $bind_network" || \
				write_log 13 "Can not detect local IP using '$__RUNPROG $bind_network' - Error: '$?'"
			write_log 7 "Force communication via IP '$__BINDIP'"
			__PROG="$__PROG --bind-address=$__BINDIP"
		fi
		if [ $force_ipversion -eq 1 ]; then
			[ $use_ipv6 -eq 0 ] && __PROG="$__PROG -4" || __PROG="$__PROG -6"
		fi
		if [ $use_https -eq 1 ]; then
			if [ "$cacert" = "IGNORE" ]; then
				__PROG="$__PROG --no-check-certificate"
			elif [ -f "$cacert" ]; then
				__PROG="$__PROG --ca-certificate=${cacert}"
			elif [ -d "$cacert" ]; then
				__PROG="$__PROG --ca-directory=${cacert}"
			elif [ -n "$cacert" ]; then
				write_log 14 "No valid certificate(s) found at '$cacert' for HTTPS communication"
			fi
		fi
		[ -z "$proxy" ] && __PROG="$__PROG --no-proxy"
		__RUNPROG="$__PROG '$__URL'"
		__PROG="GNU Wget"
	elif [ -n "$(which curl)" ]; then
		__PROG="$(which curl) -RsS -o $DATFILE --stderr $ERRFILE"
		/usr/bin/curl -V | grep "Protocols:" | grep -F "https" >/dev/null 2>&1
		[ $? -eq 1 -a $use_https -eq 1 ] && \
			write_log 13 "cURL: libcurl compiled without https support"
		if [ -n "$bind_network" ]; then
			local __DEVICE
			network_get_physdev __DEVICE $bind_network || \
				write_log 13 "Can not detect local device using 'network_get_physdev $bind_network' - Error: '$?'"
			write_log 7 "Force communication via device '$__DEVICE'"
			__PROG="$__PROG --interface $__DEVICE"
		fi
		if [ $force_ipversion -eq 1 ]; then
			[ $use_ipv6 -eq 0 ] && __PROG="$__PROG -4" || __PROG="$__PROG -6"
		fi
		if [ $use_https -eq 1 ]; then
			if [ "$cacert" = "IGNORE" ]; then
				__PROG="$__PROG --insecure"
			elif [ -f "$cacert" ]; then
				__PROG="$__PROG --cacert $cacert"
			elif [ -d "$cacert" ]; then
				__PROG="$__PROG --capath $cacert"
			elif [ -n "$cacert" ]; then
				write_log 14 "No valid certificate(s) found at '$cacert' for HTTPS communication"
			fi
		fi
		if [ -z "$proxy" ]; then
			__PROG="$__PROG --noproxy '*'"
		else
			grep -i "all_proxy" /usr/lib/libcurl.so* >/dev/null 2>&1 || \
				write_log 13 "cURL: libcurl compiled without Proxy support"
		fi
		__RUNPROG="$__PROG '$__URL'"
		__PROG="cURL"
	elif [ -n "$(which uclient-fetch)" ]; then
		__PROG="$(which uclient-fetch) -q -O $DATFILE"
		[ -n "$__BINDIP" ] && \
			write_log 14 "uclient-fetch: FORCE binding to specific address not supported"
		if [ $force_ipversion -eq 1 ]; then
			[ $use_ipv6 -eq 0 ] && __PROG="$__PROG -4" || __PROG="$__PROG -6"
		fi
		[ $use_https -eq 1 -a ! -f /lib/libustream-ssl.so ] && \
			write_log 14 "uclient-fetch: no HTTPS support! Additional install one of ustream-ssl packages"
		[ -z "$proxy" ] && __PROG="$__PROG -Y off" || __PROG="$__PROG -Y on"
		if [ $use_https -eq 1 ]; then
			if [ "$cacert" = "IGNORE" ]; then
				__PROG="$__PROG --no-check-certificate"
			elif [ -f "$cacert" ]; then
				__PROG="$__PROG --ca-certificate=$cacert"
			elif [ -n "$cacert" ]; then
				write_log 14 "No valid certificate file '$cacert' for HTTPS communication"
			fi
		fi
		__RUNPROG="$__PROG '$__URL' 2>$ERRFILE"
		__PROG="uclient-fetch"
	elif [ -n "$(which wget)" ]; then
		__PROG="$(which wget) -q -O $DATFILE"
		[ -n "$__BINDIP" ] && \
			write_log 14 "BusyBox Wget: FORCE binding to specific address not supported"
		[ $force_ipversion -eq 1 ] && \
			write_log 14 "BusyBox Wget: Force connecting to IPv4 or IPv6 addresses not supported"
		[ $use_https -eq 1 ] && \
			write_log 14 "BusyBox Wget: no HTTPS support"
		[ -z "$proxy" ] && __PROG="$__PROG -Y off"
		__RUNPROG="$__PROG '$__URL' 2>$ERRFILE"
		__PROG="Busybox Wget"
	else
		write_log 13 "Neither 'Wget' nor 'cURL' nor 'uclient-fetch' installed or executable"
	fi
	while : ; do
		write_log 7 "#> $__RUNPROG"
		eval $__RUNPROG
		__ERR=$?
		[ $__ERR -eq 0 ] && return 0
		[ $LUCI_HELPER ] && return 1
		write_log 3 "$__PROG Error: '$__ERR'"
		write_log 7 "$(cat $ERRFILE)"
		[ $VERBOSE_MODE -gt 1 ] && {
			write_log 4 "Transfer failed - Verbose Mode: $VERBOSE_MODE - NO retry on error"
			return 1
		}
		__CNT=$(( $__CNT + 1 ))
		[ $retry_count -gt 0 -a $__CNT -gt $retry_count ] && \
			write_log 14 "Transfer failed after $retry_count retries"
		write_log 4 "Transfer failed - retry $__CNT/$retry_count in $RETRY_SECONDS seconds"
		sleep $RETRY_SECONDS &
		PID_SLEEP=$!
		wait $PID_SLEEP
		PID_SLEEP=0
	done
	write_log 12 "Error in 'do_transfer()' - program coding error"
