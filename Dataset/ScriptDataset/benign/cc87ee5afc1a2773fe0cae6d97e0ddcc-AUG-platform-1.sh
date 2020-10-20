	local part

	part=$(find_mtd_part u-boot)
	[ -z "$part" ] && return 1

	dd if=$part bs=4 count=1 skip=81728 2>/dev/null | hexdump -v -n 4 -e '1/1 "%02x"'
