	local device=$1
	local vlan=$2
	local ports=$3
	uci batch <<EOF
add network switch_vlan
set network.@switch_vlan[-1].device='$device'
set network.@switch_vlan[-1].vlan='$vlan'
set network.@switch_vlan[-1].ports='$ports'
EOF
