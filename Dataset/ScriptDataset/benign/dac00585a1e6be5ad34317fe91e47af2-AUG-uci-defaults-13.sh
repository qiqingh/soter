	local name="$1"
	local port="$2"
	local key="$3"
	local val="$4"
	local ports i num

	json_select_object switch
	json_select_object "$name"

	json_get_keys ports ports
	json_select_array ports

	for i in $ports; do
		json_select "$i"
		json_get_var num num

		if [ -n "$num" ] && [ $num -eq $port ]; then
			json_select_object attr

			case "$val" in
				true|false) [ "$val" != "true" ]; json_add_boolean "$key" $? ;;
				[0-9]) json_add_int "$key" "$val" ;;
				*) json_add_string "$key" "$val" ;;
			esac

			json_select ..
		fi

		json_select ..
	done

	json_select ..
	json_select ..
	json_select ..
