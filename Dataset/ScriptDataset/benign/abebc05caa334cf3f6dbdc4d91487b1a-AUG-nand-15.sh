	local tar_file="$1"
	local board_name="$(nand_board_name)"
	local kernel_mtd="$(find_mtd_index $CI_KERNPART)"

	local kernel_length=`(tar xf $tar_file sysupgrade-$board_name/kernel -O | wc -c) 2> /dev/null`
	local rootfs_length=`(tar xf $tar_file sysupgrade-$board_name/root -O | wc -c) 2> /dev/null`

	local rootfs_type="$(identify_tar "$tar_file" sysupgrade-$board_name/root)"

	local has_kernel=1
	local has_env=0

	[ "$kernel_length" != 0 -a -n "$kernel_mtd" ] && {
		tar xf $tar_file sysupgrade-$board_name/kernel -O | mtd write - $CI_KERNPART
	}
	[ "$kernel_length" = 0 -o ! -z "$kernel_mtd" ] && has_kernel=0

	nand_upgrade_prepare_ubi "$rootfs_length" "$rootfs_type" "$has_kernel" "$has_env"

	local ubidev="$( nand_find_ubi "$CI_UBIPART" )"
	[ "$has_kernel" = "1" ] && {
		local kern_ubivol="$(nand_find_volume $ubidev kernel)"
	 	tar xf $tar_file sysupgrade-$board_name/kernel -O | \
			ubiupdatevol /dev/$kern_ubivol -s $kernel_length -
	}

	local root_ubivol="$(nand_find_volume $ubidev rootfs)"
	tar xf $tar_file sysupgrade-$board_name/root -O | \
		ubiupdatevol /dev/$root_ubivol -s $rootfs_length -

	nand_do_upgrade_success
