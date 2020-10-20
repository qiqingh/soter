	local max=128
	local host
	local gw
	while [ -n "$1" -a $max -gt 0 ]; do
		host=${1%%/*}
		gw=${1##*/}
		echo "udhcpc: adding route for $host via $gw on interface $interface" | logger
		echo route add -host "$host" gw "$gw" dev "$interface" >>${routefile}
		max=$(($max-1))
		shift 1
	done
