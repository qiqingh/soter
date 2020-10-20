	local hdr_len=$(get_le_long_at "$1" 8)

	echo -n dd skip=$hdr_len iflag=skip_bytes
