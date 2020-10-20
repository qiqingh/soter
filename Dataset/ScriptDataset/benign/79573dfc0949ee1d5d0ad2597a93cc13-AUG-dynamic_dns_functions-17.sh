	local __CNT=0
	local __ERR=255
	local __REGEX  __PROG  __RUNPROG  __DATA  __IP
	local __MUSL=$(nslookup localhost 2>&1 | grep -qF "(null)"; echo $?)
	[ $# -lt 1 -o $# -gt 2 ] && write_log 12 "Error calling 'get_registered_ip()' - wrong number of parameters"
	write_log 7 "Detect registered/public IP"
	[ $use_ipv6 -eq 0 ] && __REGEX="$IPV4_REGEX" || __REGEX="$IPV6_REGEX"
	if [ -n "$(which host)" ]; then
		__PROG="$(which host)"
		[ $use_ipv6 -eq 0 ] && __PROG="$__PROG -t A"  || __PROG="$__PROG -t AAAA"
		if [ $force_ipversion -eq 1 ]; then
			[ $use_ipv6 -eq 0 ] && __PROG="$__PROG -4"  || __PROG="$__PROG -6"
		fi
		[ $force_dnstcp -eq 1 ] && __PROG="$__PROG -T"
		__RUNPROG="$__PROG $lookup_host $dns_server >$DATFILE 2>$ERRFILE"
		__PROG="BIND host"
	elif [ -n "$(which khost)" ]; then
		__PROG="$(which khost)"
		[ $use_ipv6 -eq 0 ] && __PROG="$__PROG -t A"  || __PROG="$__PROG -t AAAA"
		if [ $force_ipversion -eq 1 ]; then
			[ $use_ipv6 -eq 0 ] && __PROG="$__PROG -4"  || __PROG="$__PROG -6"
		fi
		[ $force_dnstcp -eq 1 ] && __PROG="$__PROG -T"
		__RUNPROG="$__PROG $lookup_host $dns_server >$DATFILE 2>$ERRFILE"
		__PROG="Knot host"
	elif [ -n "$(which drill)" ]; then
		__PROG="$(which drill) -V0"
		if [ $force_ipversion -eq 1 ]; then
			[ $use_ipv6 -eq 0 ] && __PROG="$__PROG -4"  || __PROG="$__PROG -6"
		fi
		[ $force_dnstcp -eq 1 ] && __PROG="$__PROG -t" || __PROG="$__PROG -u"
		__PROG="$__PROG $lookup_host"
		[ -n "$dns_server" ] && __PROG="$__PROG @$dns_server"
		[ $use_ipv6 -eq 0 ] && __PROG="$__PROG A"  || __PROG="$__PROG AAAA"
		__RUNPROG="$__PROG >$DATFILE 2>$ERRFILE"
		__PROG="drill"
	elif [ -n "$(which hostip)" ]; then
		__PROG="$(which hostip)"
		[ $force_dnstcp -ne 0 ] && \
			write_log 14 "hostip - no support for 'DNS over TCP'"
		__IP=$(echo $dns_server | grep -m 1 -o "$IPV4_REGEX")
		[ -z "$__IP" ] && __IP=$(echo $dns_server | grep -m 1 -o "$IPV6_REGEX")
		[ -z "$__IP" -a -n "$dns_server" ] && {
			__IP="\`/usr/bin/hostip"
			[ $use_ipv6 -eq 1 -a $force_ipversion -eq 1 ] && __IP="$__IP -6"
			__IP="$__IP $dns_server | grep -m 1 -o"
			[ $use_ipv6 -eq 1 -a $force_ipversion -eq 1 ] \
				&& __IP="$__IP '$IPV6_REGEX'" \
				|| __IP="$__IP '$IPV4_REGEX'"
			__IP="$__IP \`"
		}
		[ $use_ipv6 -eq 1 ] && __PROG="$__PROG -6"
		[ -n "$dns_server" ] && __PROG="$__PROG -r $__IP"
		__RUNPROG="$__PROG $lookup_host >$DATFILE 2>$ERRFILE"
		__PROG="hostip"
	elif [ -n "$(which nslookup)" ]; then
		[ $force_ipversion -ne 0 -o $force_dnstcp -ne 0 ] && \
			write_log 14 "Busybox nslookup - no support to 'force IP Version' or 'DNS over TCP'"
		[ $__MUSL -eq 0 -a -n "$dns_server" ] && \
			write_log 14 "Busybox compiled with musl - nslookup - no support to set/use DNS Server"
		__RUNPROG="$(which nslookup) $lookup_host $dns_server >$DATFILE 2>$ERRFILE"
		__PROG="BusyBox nslookup"
	else
		write_log 12 "Error in 'get_registered_ip()' - no supported Name Server lookup software accessible"
	fi
	while : ; do
		write_log 7 "#> $__RUNPROG"
		eval $__RUNPROG
		__ERR=$?
		if [ $__ERR -ne 0 ]; then
			write_log 3 "$__PROG error: '$__ERR'"
			write_log 7 "$(cat $ERRFILE)"
		else
			if [ "$__PROG" = "BIND host" ]; then
				__DATA=$(cat $DATFILE | awk -F "address " '/has/ {print $2; exit}' )
			elif [ "$__PROG" = "Knot host" ]; then
				__DATA=$(cat $DATFILE | awk -F "address " '/has/ {print $2; exit}' )
			elif [ "$__PROG" = "drill" ]; then
				__DATA=$(cat $DATFILE | awk '/^'"$lookup_host"'/ {print $5; exit}' )
			elif [ "$__PROG" = "hostip" ]; then
				__DATA=$(cat $DATFILE | grep -m 1 -o "$__REGEX")
			else
				__DATA=$(cat $DATFILE | sed -ne "/^Name:/,\$ { s/^Address[0-9 ]\{0,\}: \($__REGEX\).*$/\\1/p }" )
			fi
			[ -n "$__DATA" ] && {
				write_log 7 "Registered IP '$__DATA' detected"
				eval "$1=\"$__DATA\""
				return 0
			}
			write_log 4 "NO valid IP found"
			__ERR=127
		fi
		[ $LUCI_HELPER ] && return $__ERR
		[ -n "$2" ] && return $__ERR
		[ $VERBOSE_MODE -gt 1 ] && {
			write_log 4 "Get registered/public IP for '$lookup_host' failed - Verbose Mode: $VERBOSE_MODE - NO retry on error"
			return $__ERR
		}
		__CNT=$(( $__CNT + 1 ))
		[ $retry_count -gt 0 -a $__CNT -gt $retry_count ] && \
			write_log 14 "Get registered/public IP for '$lookup_host' failed after $retry_count retries"
		write_log 4 "Get registered/public IP for '$lookup_host' failed - retry $__CNT/$retry_count in $RETRY_SECONDS seconds"
		sleep $RETRY_SECONDS &
		PID_SLEEP=$!
		wait $PID_SLEEP
		PID_SLEEP=0
	done
	write_log 12 "Error in 'get_registered_ip()' - program coding error"
