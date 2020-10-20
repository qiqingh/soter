	dbg2 "# Setup rps of the interfaces, $RPS_IF_LIST."
	for i in $RPS_IF_LIST; do
		var=${VAR_PREFIX}_${i//-/_}
		eval cpu_map=\$$var
		if [ -d /sys/class/net/$i ]; then
			if [ ! -z $cpu_map ]; then
				cpu_map=`printf '%x' $cpu_map`
				dbg "echo $cpu_map > /sys/class/net/$i/queues/rx-0/rps_cpus"
				echo $cpu_map > /sys/class/net/$i/queues/rx-0/rps_cpus
			elif [ ! -z $1 ]; then
				dbg "echo $1 > /sys/class/net/$i/queues/rx-0/rps_cpus"
				echo $1 > /sys/class/net/$i/queues/rx-0/rps_cpus
			fi
		fi
	done
