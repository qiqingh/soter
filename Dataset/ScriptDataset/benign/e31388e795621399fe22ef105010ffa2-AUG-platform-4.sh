	local partitions=$(platform_find_partitions)
	local kernelpart=$(platform_find_kernelpart "${partitions#*:}")
	local erase_size=$((0x${partitions%%:*})); partitions="${partitions#*:}"
	local kern_part_size=0x$(platform_find_part_size "$kernelpart")
	local kern_part_blocks=$(($kern_part_size / $CI_BLKSZ))
	local kern_length=0x$(dd if="$1" bs=2 skip=1 count=4 2>/dev/null)
	local kern_blocks=$(($kern_length / $CI_BLKSZ))
	local root_blocks=$((0x$(dd if="$1" bs=2 skip=5 count=4 2>/dev/null) / $CI_BLKSZ))

	v "platform_do_upgrade_combined"
	v "partitions=$partitions"
	v "kernelpart=$kernelpart"
	v "kernel_part_size=$kern_part_size"
	v "kernel_part_blocks=$kern_part_blocks"
	v "kern_length=$kern_length"
	v "erase_size=$erase_size"
	v "kern_blocks=$kern_blocks"
	v "root_blocks=$root_blocks"
	v "kern_pad_blocks=$(($kern_part_blocks-$kern_blocks))"

	if [ -n "$partitions" ] && [ -n "$kernelpart" ] && \
	   [ ${kern_blocks:-0} -gt 0 ] && \
	   [ ${root_blocks:-0} -gt 0 ] && \
	   [ ${erase_size:-0} -gt 0 ];
	then
		local append=""
		[ -f "$UPGRADE_BACKUP" ] && append="-j $UPGRADE_BACKUP"

		# write the kernel
		dd if="$1" bs=$CI_BLKSZ skip=1 count=$kern_blocks 2>/dev/null | \
			mtd -F$kernelpart:$kern_part_size:$CI_LDADR write - $kernelpart
		# write the rootfs
		dd if="$1" bs=$CI_BLKSZ skip=$((1+$kern_blocks)) count=$root_blocks 2>/dev/null | \
			mtd $append write - rootfs
	else
		echo "invalid image"
	fi
