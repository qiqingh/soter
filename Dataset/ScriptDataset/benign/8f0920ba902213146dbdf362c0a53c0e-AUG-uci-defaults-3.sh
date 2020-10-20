	local name="$1"
	local iface="$2"
	local proto="$3"

	json_select_object "$name"
	json_add_string ifname "$iface"

	if ! json_is_a protocol string; then
		case "$proto" in
			static|dhcp|none|pppoe) : ;;
			*)
				case "$name" in
					lan) proto="static" ;;
					wan) proto="dhcp" ;;
					*) proto="none" ;;
				esac
			;;
		esac

		json_add_string protocol "$proto"
	fi

	json_select ..
