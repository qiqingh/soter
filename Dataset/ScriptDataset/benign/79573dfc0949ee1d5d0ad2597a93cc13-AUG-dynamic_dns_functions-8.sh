	[ $# -ne 3 ] && write_log 12 "Error calling 'get_service_data()' - wrong number of parameters"
	__FILE="/usr/lib/ddns/services"
	[ $use_ipv6 -ne 0 ] && __FILE="/usr/lib/ddns/services_ipv6"
	mkfifo pipe_$$
	sed '/^#/d/^[ \t]*$/ds/\"//g' $__FILE  > pipe_$$ &
	while read __SERVICE __DATA __ANSWER; do
		if [ "$__SERVICE" = "$service_name" ]; then
			__URL=$(echo "$__DATA" | grep "^http")
			[ -z "$__URL" ] && __SCRIPT="/usr/lib/ddns/$__DATA"
			eval "$1=\"$__URL\""
			eval "$2=\"$__SCRIPT\""
			eval "$3=\"$__ANSWER\""
			rm pipe_$$
			return 0
		fi
	done < pipe_$$
	rm pipe_$$
	eval "$1=\"\""
	eval "$2=\"\""
	eval "$3=\"\""
	return 1
