	local source=$1
	local offset=$(($2))
	local count=$(($3))

	dd if=$source of=/lib/firmware/$FIRMWARE iflag=skip_bytes bs=$count skip=$offset count=1 2>/dev/null || \
		caldata_die "failed to extract calibration data from $source"
