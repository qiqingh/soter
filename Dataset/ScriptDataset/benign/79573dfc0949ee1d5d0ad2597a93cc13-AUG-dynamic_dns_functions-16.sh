	local __CNT=0
	local __RUNPROG __DATA __URL __ERR
	[ $# -ne 1 ] && write_log 12 "Error calling 'get_local_ip()' - wrong number of parameters"
	write_log 7 "Detect local IP on '$ip_source'"
	while : ; do
		case $ip_source in
			network)
				[ $use_ipv6 -eq 0 ] && __RUNPROG="network_get_ipaddr" \
						    || __RUNPROG="network_get_ipaddr6"
				eval "$__RUNPROG __DATA $ip_network" || \
					write_log 13 "Can not detect local IP using $__RUNPROG '$ip_network' - Error: '$?'"
				[ -n "$__DATA" ] && write_log 7 "Local IP '$__DATA' detected on network '$ip_network'"
				;;
			interface)
				write_log 7 "#> ifconfig $ip_interface >$DATFILE 2>$ERRFILE"
				ifconfig $ip_interface >$DATFILE 2>$ERRFILE
				__ERR=$?
				if [ $__ERR -eq 0 ]; then
					if [ $use_ipv6 -eq 0 ]; then
						__DATA=$(awk '
							/inet addr:/ {
							$1="";
							$3="";
							$4="";
							FS=":";
							$0=$0;
							$1="";
							FS=" ";
							$0=$0;
							print $1;
							}' $DATFILE
						)
					else
						__DATA=$(awk '
							/inet6/ && /: [0-9a-eA-E]/ {
							FS="/";
							$0=$0;
							$2="";
							FS=" ";
							$0=$0;
							print $3;
							}' $DATFILE
						)
					fi
					[ -n "$__DATA" ] && write_log 7 "Local IP '$__DATA' detected on interface '$ip_interface'"
				else
					write_log 3 "ifconfig Error: '$__ERR'"
					write_log 7 "$(cat $ERRFILE)"
				fi
				;;
			script)
				write_log 7 "#> $ip_script >$DATFILE 2>$ERRFILE"
				eval $ip_script >$DATFILE 2>$ERRFILE
				__ERR=$?
				if [ $__ERR -eq 0 ]; then
					__DATA=$(cat $DATFILE)
					[ -n "$__DATA" ] && write_log 7 "Local IP '$__DATA' detected via script '$ip_script'"
				else
					write_log 3 "$ip_script Error: '$__ERR'"
					write_log 7 "$(cat $ERRFILE)"
				fi
				;;
			web)
				do_transfer "$ip_url"
				[ $use_ipv6 -eq 0 ] \
					&& __DATA=$(grep -m 1 -o "$IPV4_REGEX" $DATFILE) \
					|| __DATA=$(grep -m 1 -o "$IPV6_REGEX" $DATFILE)
				[ -n "$__DATA" ] && write_log 7 "Local IP '$__DATA' detected on web at '$ip_url'"
				;;
			*)
				write_log 12 "Error in 'get_local_ip()' - unhandled ip_source '$ip_source'"
				;;
		esac
		[ -n "$__DATA" ] && {
			eval "$1=\"$__DATA\""
			return 0
		}
		[ $LUCI_HELPER ] && return 1
		write_log 7 "Data detected:\n$(cat $DATFILE)"
		[ $VERBOSE_MODE -gt 1 ] && {
			write_log 4 "Get local IP via '$ip_source' failed - Verbose Mode: $VERBOSE_MODE - NO retry on error"
			return 1
		}
		__CNT=$(( $__CNT + 1 ))
		[ $retry_count -gt 0 -a $__CNT -gt $retry_count ] && \
			write_log 14 "Get local IP via '$ip_source' failed after $retry_count retries"
		write_log 4 "Get local IP via '$ip_source' failed - retry $__CNT/$retry_count in $RETRY_SECONDS seconds"
		sleep $RETRY_SECONDS &
		PID_SLEEP=$!
		wait $PID_SLEEP
		PID_SLEEP=0
	done
	write_log 12 "Error in 'get_local_ip()' - program coding error"
