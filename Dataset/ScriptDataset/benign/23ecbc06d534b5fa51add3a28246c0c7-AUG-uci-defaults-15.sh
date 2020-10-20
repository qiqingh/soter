	local lan_ifname=$1
	local wan_ifname=$2

	ucidef_set_interface_lan "$lan_ifname"
	ucidef_set_interface_wan "$wan_ifname"
