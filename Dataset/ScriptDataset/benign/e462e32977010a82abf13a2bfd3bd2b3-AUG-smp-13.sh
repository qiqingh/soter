	dbg2 "# Setup affinity of each physical irq."
	num=0
	while [ "$num" -lt "$NUM_OF_CPU" ];do
		eval smp_list=\$CPU${num}_AFFINITY
		for i in $smp_list; do
			cpu_bit=$((2 ** $num))
			virq=$i
			dbg2 "irq p2v $i --> $virq"
			if [ ! -z $virq ]; then
				dbg "echo $cpu_bit > /proc/irq/$virq/smp_affinity"
				echo $cpu_bit > /proc/irq/$virq/smp_affinity
			fi
		done
		num=`expr $num + 1`
	done
