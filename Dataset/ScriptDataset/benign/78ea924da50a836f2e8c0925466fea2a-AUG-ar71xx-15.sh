	local part
	part=$(find_mtd_part 'product-info')
	[ -z "$part" ] && return 1

	dd if=$part iflag=skip_bytes bs=64 skip=4360 count=1 2>/dev/null | tr -d '\r\0' | head -n 1
