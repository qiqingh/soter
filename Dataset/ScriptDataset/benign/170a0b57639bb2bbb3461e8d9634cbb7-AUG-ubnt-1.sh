	local factory_mtd=$1
	local current_kernel_index=$(hexdump -s $UBNT_ERX_KERNEL_INDEX_OFFSET -n 1 -e '/1 "%X "' ${factory_mtd})

	if [ $current_kernel_index == "0" ]; then
		echo 'kernel2'
	elif [ $current_kernel_index == "1" ]; then
		echo 'kernel1'
	fi
