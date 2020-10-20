	local ifname=$1

	uci batch <<EOF
set network.lan='interface'
set network.lan.ifname='$ifname'
set network.lan.force_link=1
set network.lan.type='bridge'
set network.lan.proto='static'
set network.lan.ipaddr='192.168.1.1'
set network.lan.netmask='255.255.255.0'
set network.lan.ip6assign='60'
EOF
