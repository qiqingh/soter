	local dir="/tmp/sysupgrade-bcm53xx"
	local offset=$(oseama info "$1" -e 0 | grep "Entity offset:" | sed "s/.*:\s*//")
	local size=$(oseama info "$1" -e 0 | grep "Entity size:" | sed "s/.*:\s*//")

	# Busybox doesn't support required iflag-s
	# echo -n dd iflag=skip_bytes,count_bytes skip=$offset count=$size

	rm -fR $dir
	mkdir -p $dir
	dd if="$1" of=$dir/image-noheader.bin bs=$offset skip=1
	dd if=$dir/image-noheader.bin of=$dir/image-entity.bin bs=$size count=1

	echo -n $dir/image-entity.bin
