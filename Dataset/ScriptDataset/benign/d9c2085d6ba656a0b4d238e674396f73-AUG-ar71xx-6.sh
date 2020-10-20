	local part

	part=$(find_mtd_part firmware)
	[ -z "$part" ] && return 1

	dd bs=8 count=1 skip=0 if=$part 2>/dev/null | hexdump -v -n 8 -e '1/1 "%02x"'
