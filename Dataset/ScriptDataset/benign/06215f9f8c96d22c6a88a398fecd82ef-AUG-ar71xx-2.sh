	local mtd="$1"
	ar71xx_get_mtd_offset_size_format "$mtd" 0 4 %02x
