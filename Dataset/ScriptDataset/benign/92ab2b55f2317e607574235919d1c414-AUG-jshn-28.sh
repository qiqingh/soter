	while [ "$#" -gt 0 ]; do
		local _var="$1"; shift
		if [ "$_var" != "${_var#*:}" ]; then
			json_get_var "${_var%%:*}" "${_var%%:*}" "${_var#*:}"
		else
			json_get_var "$_var" "$_var"
		fi
	done
