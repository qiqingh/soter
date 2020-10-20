	local lan_if="$1"
	local wan_if="$2"

	ucidef_set_interface_lan "$lan_if"
	ucidef_set_interface_wan "$wan_if"
