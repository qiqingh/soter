	local name=$1
	local reset=$2
	local enable=$3
	uci batch <<EOF
add network switch
set network.@switch[-1].name='$name'
set network.@switch[-1].reset='$reset'
set network.@switch[-1].enable_vlan='$enable'
EOF
