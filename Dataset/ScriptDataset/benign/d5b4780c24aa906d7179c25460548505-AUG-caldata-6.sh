	local source=$1
	local offset=$(($2))
	local count=$(($3))

	# test extract to /dev/null first
	dd if=$source of=/dev/null iflag=skip_bytes bs=$count skip=$offset count=1 2>/dev/null || \
		caldata_die "failed to extract calibration data from $source"

	# can't fail now
	echo 1 > /sys/$DEVPATH/loading
	dd if=$source of=/sys/$DEVPATH/data iflag=skip_bytes bs=$count skip=$offset count=1 2>/dev/null
	echo 0 > /sys/$DEVPATH/loading
