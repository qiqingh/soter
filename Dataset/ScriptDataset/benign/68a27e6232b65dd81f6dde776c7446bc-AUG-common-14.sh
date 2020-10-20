	local magic=$(get_magic_vfat "$@")
	[ "$magic" = "FAT" ]
