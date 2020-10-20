	local factory_mtd=$(find_mtd_part factory)
	if [ -z "$factory_mtd" ]; then
		echo "cannot find factory partition" >&2
		exit 1
	fi

	local kernel_part="$(ubnt_get_target_kernel ${factory_mtd})"
	if [ -z "$kernel_part" ]; then
		echo "cannot find factory partition" >&2
		exit 1
	fi

	# This is a global defined in nand.sh, sets partition kernel will be flashed into
	CI_KERNPART=${kernel_part}

	#Remove volume possibly left over from stock firmware
	local ubidev="$( nand_find_ubi "$CI_UBIPART" )"
	if [ -z "$ubidev" ]; then
		local mtdnum="$( find_mtd_index "$CI_UBIPART" )"
		if [ -z "$mtdnum" ]; then
			echo "cannot find ubi mtd partition $CI_UBIPART" >&2
			exit 1
		fi
		ubiattach -m "$mtdnum"
		sync
		ubidev="$( nand_find_ubi "$CI_UBIPART" )"
	fi
	if [ -n "$ubidev" ]; then
		local troot_ubivol="$( nand_find_volume $ubidev troot )"
		[ -n "$troot_ubivol" ] && ubirmvol /dev/$ubidev -N troot || true
	fi

	ubnt_update_target_kernel ${factory_mtd} ${kernel_part} || exit 1

	nand_do_upgrade "$1"
