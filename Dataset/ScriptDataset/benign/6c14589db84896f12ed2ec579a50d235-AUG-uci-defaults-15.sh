	local network="$1"
	local macaddr="$2"

	ucidef_set_interface "$network" macaddr "$macaddr"
