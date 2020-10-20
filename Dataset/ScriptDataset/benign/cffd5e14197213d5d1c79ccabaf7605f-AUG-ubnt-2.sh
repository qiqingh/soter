	local factory_mtd=$1
	local kernel_part=$2

	local new_kernel_index
	if [ $kernel_part == "kernel1" ]; then
		new_kernel_index="\x00"
	elif [ $kernel_part == "kernel2" ]; then
		new_kernel_index="\x01"
	else
		echo 'Unknown kernel image index' >&2
		return 1
	fi

	if ! (echo -e $new_kernel_index | dd of=${factory_mtd} bs=1 count=1 seek=$UBNT_ERX_KERNEL_INDEX_OFFSET); then
		echo 'Failed to update kernel bootup index' >&2
		return 1
	fi
