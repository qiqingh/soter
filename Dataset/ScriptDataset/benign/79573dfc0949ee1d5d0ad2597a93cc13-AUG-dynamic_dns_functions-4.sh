	local __PID=0
	local __PIDFILE="$RUNDIR/$1.pid"
	[ $# -ne 1 ] && write_log 12 "Error calling 'stop_section_processes()' - wrong number of parameters"
	[ -e "$__PIDFILE" ] && {
		__PID=$(cat $__PIDFILE)
		ps | grep "^[\t ]*$__PID" >/dev/null 2>&1 && kill $__PID || __PID=0
	}
	[ $__PID -eq 0 ]
