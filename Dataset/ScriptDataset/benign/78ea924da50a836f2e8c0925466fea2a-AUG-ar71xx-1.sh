	local mtd="$1"
	local offset="$2"
	local size="$3"
	local format="$4"
	local dev

	dev=$(find_mtd_part $mtd)
	[ -z "$dev" ] && return

	dd if=$dev iflag=skip_bytes bs=$size skip=$offset count=1 2>/dev/null | hexdump -v -e "1/1 \"$format\""
