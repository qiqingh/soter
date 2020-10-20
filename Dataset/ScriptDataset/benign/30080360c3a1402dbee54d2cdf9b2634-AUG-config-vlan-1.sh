	echo "Usage:"
	echo "  $0 0 0 - restore IC+ to no VLAN partition"
	echo "  $0 0 LLLLW - config IC+ with VLAN and WAN at port 4"
	echo "  $0 0 WLLLL - config IC+ with VLAN and WAN at port 0"
	echo "  $0 1 0 - restore Vtss to no VLAN partition"
	echo "  $0 1 LLLLW - config Vtss with VLAN and WAN at port 4"
	echo "  $0 1 WLLLL - config Vtss with VLAN and WAN at port 0"
	echo "  $0 2 0 - restore Ralink ESW to no VLAN partition"
	echo "  $0 2 LLLLW - config Ralink ESW with VLAN and WAN at port 4"
	echo "  $0 2 WLLLL - config Ralink ESW with VLAN and WAN at port 0"
	echo "  $0 2 W1234 - config Ralink ESW with VLAN 5 at port 0 and VLAN 1~4 at port 1~4"
	echo "  $0 2 12345 - config Ralink ESW with VLAN 1~5 at port 0~4"
	echo "  $0 2 VLAN - config Ralink ESW with VLAN Settings and WAN at port 4"
	echo "  $0 2 GW - config Ralink ESW with WAN at Giga port"
	echo "  $0 2 G01234 - config Ralink ESW with VLAN 6 at Giga port, and VLAN 1~5 at port 0~4"
	echo "  $0 3 0 - restore Ralink RT6855/MT7620/MT7621 ESW to no VLAN partition"
	echo "  $0 3 LLLLW - config Ralink RT6855/MT7620/MT7621 ESW with VLAN and WAN at port 4"
	echo "  $0 3 WLLLL - config Ralink RT6855/MT7620/MT7621 ESW with VLAN and WAN at port 0"
	echo "  $0 3 12345 - config Ralink RT6855/MT7620/MT7621 ESW with VLAN 1~5 at port 0~4"
	echo "  $0 3 GW - config Ralink RT6855/MT7620/MT7621 ESW with WAN at Giga port"
	exit 0