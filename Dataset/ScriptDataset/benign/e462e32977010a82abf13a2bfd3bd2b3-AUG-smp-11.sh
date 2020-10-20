	dbg2 "# Scan binding interfaces of each cpu"
	# suppose the value of interface_var is null or hex
	num=0
	while [ "$num" -lt "$NUM_OF_CPU" ];do
		cpu_bit=$((2 ** $num))
		eval rps_list=\$CPU${num}_RPS
		dbg2 "# CPU$num: rps_list=$rps_list"
		for i in $rps_list; do
			var=${VAR_PREFIX}_${i//-/_}
			eval ifval=\$$var
			dbg2 "[var val before] \$$var=$ifval"
			if [ -z "$ifval" ]; then
				eval $var=$cpu_bit
			else
				eval $var=`expr $ifval + $cpu_bit`
			fi
			eval ifval=\$$var
			dbg2 "[rps val after]$i=$ifval"
		done
		num=`expr $num + 1`
	done
