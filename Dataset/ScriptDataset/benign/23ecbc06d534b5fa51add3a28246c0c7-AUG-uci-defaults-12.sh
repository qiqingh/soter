	local cfg=$1
	local ifname=$2
	local proto=${3:-"none"}

	uci batch <<EOF
set network.$cfg='interface'
set network.$cfg.ifname='$ifname'
set network.$cfg.proto='$proto'
EOF
