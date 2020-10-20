	local part
	part=$(find_mtd_part 'product-info')
	[ -z "$part" ] && return 1

	dd if=$part bs=1 skip=4360 count=64 2>/dev/null | tr -d '\r\0' | head -n 1
