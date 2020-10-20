	[ $# -ne 1 ] && write_log 12 "Error calling 'verify_host_port()' - wrong number of parameters"
	local __UPTIME=$(cat /proc/uptime)
	eval "$1=\"${__UPTIME%%.*}\""
