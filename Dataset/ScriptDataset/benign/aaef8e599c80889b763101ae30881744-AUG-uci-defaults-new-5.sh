	local lan_if=$1

	json_select_object network
	_ucidef_set_interface lan $lan_if
	json_select ..
