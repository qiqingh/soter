	local header_len=$((0x$(get_magic_long_at "$1" 4)))

	echo -n dd bs=$header_len skip=1
