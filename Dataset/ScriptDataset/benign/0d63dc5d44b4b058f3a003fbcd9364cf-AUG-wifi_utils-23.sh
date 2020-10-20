	if [ "11n" = "$1" -o "11b 11g 11n" = "$1" -o "11a 11n" = "$1" -o "11a 11n 11ac" = "$1" ]; then
		N_MODE=1
	else
		N_MODE=0
	fi
	echo "$N_MODE"
