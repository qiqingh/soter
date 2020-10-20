	local network=$1

	[ -z "$network" ] && return

	json_select_object network
	json_select_object "$network"
	shift

	while [ -n "$1" ]; do
		local opt="$1"
		local val="$2"
		shift; shift;

		[ -n "$opt" -a -n "$val" ] || break

		json_add_string "$opt" "$val"
	done

	json_select ..
	json_select ..
