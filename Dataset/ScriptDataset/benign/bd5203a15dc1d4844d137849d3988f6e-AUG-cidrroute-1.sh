local max=128
	local type
	while [ -n "$1" -a -n "$2" -a $max -gt 0 ]; do
		if [ ${1##*/} -eq 32 ] 
		then 
			type=host
			target=${1%/32}
		else
			type=net
			target=$1
		fi
		
		echo "udhcpc: adding route for $type $target via $2 on interface $interface " | logger
		echo route add -${type} "$target" gw "$2" dev "$interface" >>${routefile}
		max=$(($max-1))
		shift 2
	done
