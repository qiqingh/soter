	local part
	part=$(find_mtd_part 'product-info')
	[ -z "$part" ] && return 1

	# The returned string will end with \r\n, but we don't remove it here
	# to simplify matching against it in the sysupgrade image check
	dd if=$part bs=1 skip=4360 2>/dev/null | head -n 1
