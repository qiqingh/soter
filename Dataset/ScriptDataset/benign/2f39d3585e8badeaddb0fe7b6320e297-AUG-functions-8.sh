	local cfgtype="$1"
	local name="$2"

	export ${NO_EXPORT:+-n} CONFIG_NUM_SECTIONS=$((CONFIG_NUM_SECTIONS + 1))
	name="${name:-cfg$CONFIG_NUM_SECTIONS}"
	append CONFIG_SECTIONS "$name"
	export ${NO_EXPORT:+-n} CONFIG_SECTION="$name"
	config_set "$CONFIG_SECTION" "TYPE" "${cfgtype}"
	[ -n "$NO_CALLBACK" ] || config_cb "$cfgtype" "$name"
