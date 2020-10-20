	local name=$1
	local vlan=$2
	local ports=$3
	local cpu_port=''

	case $vlan in
	1)	vlan=lan;;
	2)	vlan=wan;;
	*)	vlan=vlan$vlan;;
	esac

	json_select_object switch
	json_select_object $name
	json_select_object vlans

	json_add_array $vlan
	for p in $ports; do
		if [ ${p%t} != $p ]; then
			cpu_port=$p
		else
			json_add_int "" $p
		fi
	done
	json_close_array

	json_select ..
	[ -n "$cpu_port" ] && json_add_int cpu_port $cpu_port
	json_select ..
	json_select ..
