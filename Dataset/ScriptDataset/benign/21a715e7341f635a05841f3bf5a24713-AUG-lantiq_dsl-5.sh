	local val=$1
	local a
	local b

	if [ "$val" -gt 1000000 ]; then
		a=$(expr $val / 1000)
		b=$(expr $a % 1000)
		a=$(expr $a / 1000)
		printf "%d.%03d Mb" ${a} ${b}
	elif [ "$val" -gt 1000 ]; then
		a=$(expr $val / 1000)
		printf "%d Kb" ${a}
	else
		echo "${val} b"
	fi
