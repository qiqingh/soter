	local mtd_blk=$(find_mtd_part config)

	if [ -z "$mtd_blk" ]; then
		echo "k2t_config_load: no mtd part named config" >&2
		exit 1
	fi

	local json_size=$(dd if=$mtd_blk bs=1 count=8 2>/dev/null)

	json_size="0x$json_size"
	json_size=$((json_size))

	if [ "$?" -ne 0 ]; then
		echo "k2t_config_load: invalid json data size" >&2
		exit 2
	fi

	if [ "$json_size" -eq 0 ]; then
		echo "k2t_config_load: empty json data" >&2
		exit 3
	fi

	local json_data=$(dd if=$mtd_blk bs=1 skip=8 count=$json_size 2>/dev/null)

	json_load "$json_data"
