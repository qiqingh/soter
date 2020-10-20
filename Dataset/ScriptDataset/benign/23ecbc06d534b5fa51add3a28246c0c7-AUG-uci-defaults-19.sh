	local device=$1
	local port=$2
	uci batch <<EOF
add network switch_port
set network.@switch_port[-1].device='$device'
set network.@switch_port[-1].port='$port'
EOF
