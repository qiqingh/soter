	local cfg="/etc/board.json"
	local macaddr

	[ -s "$cfg" ] || return

	json_init
	json_load "$(cat $cfg)"
	if json_is_a system object; then
		json_select system
			json_get_var macaddr label_macaddr
		json_select ..
	fi

	echo $macaddr
