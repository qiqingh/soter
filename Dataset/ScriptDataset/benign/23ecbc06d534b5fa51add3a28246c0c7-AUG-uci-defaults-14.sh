	local ifname=$1

	uci batch <<EOF
set network.wan='interface'
set network.wan.ifname='$ifname'
set network.wan.proto='dhcp'
set network.wan6='interface'
set network.wan6.ifname='$ifname'
set network.wan6.proto='dhcpv6'
EOF
