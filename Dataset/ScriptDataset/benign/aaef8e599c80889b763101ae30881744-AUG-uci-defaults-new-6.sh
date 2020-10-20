	local lan_if=$1
	local wan_if=$2

	json_select_object network
	_ucidef_set_interface lan $lan_if
	_ucidef_set_interface wan $wan_if
	json_select ..
