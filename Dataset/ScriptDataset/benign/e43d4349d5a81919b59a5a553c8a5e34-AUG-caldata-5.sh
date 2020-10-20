	local source=$1
	local offset=$(($2))
	local count=$(($3))
	local target=$4

	[ -n "$target" ] || target=/lib/firmware/$FIRMWARE

	# dd doesn't handle partial reads from special files: use cat
	cat $source | dd of=$target iflag=skip_bytes bs=$count skip=$offset count=1 2>/dev/null || \
		caldata_die "failed to extract calibration data from $source"
