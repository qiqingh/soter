	local mtdname="$1"
	local offset="$2"
	local part

	part=$(find_mtd_part "$mtdname")
	if [ -z "$part" ]; then
		echo "mtd_get_mac_binary: partition $mtdname not found!" >&2
		return
	fi

	hexdump -v -n 6 -s $offset -e '5/1 "%02x:" 1/1 "%02x"' $part 2>/dev/null
