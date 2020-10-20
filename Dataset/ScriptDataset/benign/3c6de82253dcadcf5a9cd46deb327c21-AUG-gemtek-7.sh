	local ipaddr="$1"
	local netmask="$2"
	local p1 p2 p3 p4
	local mask1 mask2 mask3 mask4

	strtok $ipaddr p1 . p2 . p3 . p4
	strtok $netmask mask1 . mask2 . mask3 . mask4
	echo "$(($p1 & $mask1)).$(($p2 & $mask2)).$(($p3 & $mask3)).$(($p4 & $mask4))"
