	local __HOST=$1
	local __PORT=$2
	local __IP __IPV4 __IPV6 __RUNPROG __PROG __ERR
	[ $# -ne 2 ] && write_log 12 "Error calling 'verify_host_port()' - wrong number of parameters"
	__IPV4=$(echo $__HOST | grep -m 1 -o "$IPV4_REGEX$")
	__IPV6=$(echo $__HOST | grep -m 1 -o "$IPV6_REGEX")
	[ -z "$__IPV4" -a -z "$__IPV6" ] && {
		if [ -n "$(which host)" ]; then
			__PROG="BIND host"
			__RUNPROG="$(which host) -t ANY $__HOST >$DATFILE 2>$ERRFILE"
		else
			__PROG="BusyBox nslookup"
			__RUNPROG="$(which nslookup) $__HOST >$DATFILE 2>$ERRFILE"
		fi
		write_log 7 "#> $__RUNPROG"
		eval $__RUNPROG
		__ERR=$?
		[ $__ERR -gt 0 ] && {
			write_log 3 "DNS Resolver Error - $__PROG Error '$__ERR'"
			write_log 7 "$(cat $ERRFILE)"
			return 2
		}
		if [ -x /usr/bin/host ]; then
			__IPV4=$(cat $DATFILE | awk -F "address " '/has address/ {print $2; exit}' )
			__IPV6=$(cat $DATFILE | awk -F "address " '/has IPv6/ {print $2; exit}' )
		else
			__IPV4=$(cat $DATFILE | sed -ne "/^Name:/,\$ { s/^Address[0-9 ]\{0,\}: \($IPV4_REGEX\).*$/\\1/p }")
			__IPV6=$(cat $DATFILE | sed -ne "/^Name:/,\$ { s/^Address[0-9 ]\{0,\}: \($IPV6_REGEX\).*$/\\1/p }")
		fi
	}
	if [ $force_ipversion -ne 0 ]; then
		__ERR=0
		[ $use_ipv6 -eq 0 -a -z "$__IPV4" ] && __ERR=4
		[ $use_ipv6 -eq 1 -a -z "$__IPV6" ] && __ERR=6
		[ $__ERR -gt 0 ] && {
			[ $LUCI_HELPER ] && return 4
			write_log 14 "Verify host Error '4' - Forced IP Version IPv$__ERR don't match"
		}
	fi
	/usr/bin/nc --help 2>&1 | grep -i "NO OPT l!" >/dev/null 2>&1 && \
		write_log 12 "Busybox nc (netcat) compiled without '-l' option, error 'NO OPT l!'"
	/usr/bin/nc --help 2>&1 | grep "\-w" >/dev/null 2>&1 && __NCEXT="TRUE"
	[ $force_ipversion -ne 0 -a $use_ipv6 -ne 0 -o -z "$__IPV4" ] && __IP=$__IPV6 || __IP=$__IPV4
	if [ -n "$__NCEXT" ]; then
		__RUNPROG="/usr/bin/nc -w 1 $__IP $__PORT </dev/null >$DATFILE 2>$ERRFILE"
		write_log 7 "#> $__RUNPROG"
		eval $__RUNPROG
		__ERR=$?
		[ $__ERR -eq 0 ] && return 0
		write_log 3 "Connect error - BusyBox nc (netcat) Error '$__ERR'"
		write_log 7 "$(cat $ERRFILE)"
		return 3
	else
		__RUNPROG="timeout 2 -- /usr/bin/nc $__IP $__PORT </dev/null >$DATFILE 2>$ERRFILE"
		write_log 7 "#> $__RUNPROG"
		eval $__RUNPROG
		__ERR=$?
		[ $__ERR -eq 0 ] && return 0
		write_log 3 "Connect error - BusyBox nc (netcat) timeout Error '$__ERR'"
		return 3
	fi
