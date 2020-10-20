	local ubidev="$( nand_find_ubi ubi )"
	local mtdnum2="$( find_mtd_index rootfs_1 )"

	if [ ! "$mtdnum2" ]; then
		echo "cannot find second ubi mtd partition rootfs_1"
		return 1
	fi

	local ubidev2="$( nand_find_ubi rootfs_1 )"
	if [ ! "$ubidev2" ] && [ -n "$mtdnum2" ]; then
		ubiattach -m "$mtdnum2"
		ubidev2="$( nand_find_ubi rootfs_1 )"
	fi

	ubirmvol /dev/$ubidev -N ubi_rootfs_data &> /dev/null || true
	ubirmvol /dev/$ubidev2 -N kernel &> /dev/null || true
