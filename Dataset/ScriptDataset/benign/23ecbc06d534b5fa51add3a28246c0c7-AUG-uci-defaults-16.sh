	local ifname=$1
	local mac=$2

	uci batch <<EOF
set network.$ifname.macaddr='$mac'
EOF
