    state=$1
    if [ -z "$state" ]; then
	state=$(sysevent get fwup_state)
    fi
    [ $state -gt 2 ] && return 0
    return 1
