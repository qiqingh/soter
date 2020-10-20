	local varname="$1"; shift
	local value="$*"

	config_set "$CONFIG_SECTION" "${varname}" "${value}"
	[ -n "$NO_CALLBACK" ] || option_cb "$varname" "$*"
