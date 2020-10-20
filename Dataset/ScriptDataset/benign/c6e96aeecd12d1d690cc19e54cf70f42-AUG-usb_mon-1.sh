	local gpio=$1
	local valus=""
	local status=""
	value=`cat /sys/class/gpio/gpio8/value`

	if [ "${value}" = "1" ];then
		status="1"
	elif [ "${value}" = "0" ];then
		status="0"
	else
		status="error"
	fi

	Cur_val=$status	
