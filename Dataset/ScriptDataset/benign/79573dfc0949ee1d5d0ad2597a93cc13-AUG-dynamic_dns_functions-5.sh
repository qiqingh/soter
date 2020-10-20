	local __EVENTIF="$1"
	local __SECTIONS=""
	local __SECTIONID=""
	local __IFACE=""
	load_all_service_sections __SECTIONS
	for __SECTIONID in $__SECTIONS;	do
		config_get __IFACE "$__SECTIONID" interface "wan"
		[ -z "$__EVENTIF" -o "$__IFACE" = "$__EVENTIF" ] || continue
		stop_section_processes "$__SECTIONID"
	done