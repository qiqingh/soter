	local mtdname="$1"
	local key="$2"
	local part
	local mac_dirty

	part=$(find_mtd_part "$mtdname")
	if [ -z "$part" ]; then
		echo "mtd_get_mac_ascii: partition $mtdname not found!" >&2
		return
	fi

	mac_dirty=$(strings "$part" | sed -n 's/^'"$key"'=//p')

	# "canonicalize" mac
	[ -n "$mac_dirty" ] && macaddr_canonicalize "$mac_dirty"
