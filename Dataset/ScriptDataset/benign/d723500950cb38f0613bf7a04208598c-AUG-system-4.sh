	local mtdname=$1
	local offset=$2
	local part
	local mac_dirty

	part=$(find_mtd_part "$mtdname")
	if [ -z "$part" ]; then
		echo "mtd_get_mac_text: partition $mtdname not found!" >&2
		return
	fi

	if [ -z "$offset" ]; then
		echo "mtd_get_mac_text: offset missing!" >&2
		return
	fi

	mac_dirty=$(dd if="$part" bs=1 skip="$offset" count=17 2>/dev/null)

	# "canonicalize" mac
	[ -n "$mac_dirty" ] && macaddr_canonicalize "$mac_dirty"
