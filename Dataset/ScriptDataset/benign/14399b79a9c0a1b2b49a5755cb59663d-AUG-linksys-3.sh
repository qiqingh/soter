	local magic_long="$(get_magic_long "$1")"

	mkdir -p /var/lock
	local part_label="$(linksys_get_target_firmware)"
	touch /var/lock/fw_printenv.lock

	if [ ! -n "$part_label" ]
	then
		echo "cannot find target partition"
		exit 1
	fi

	local target_mtd=$(find_mtd_part $part_label)

	[ "$magic_long" = "73797375" ] && {
		CI_KERNPART="$part_label"
		if [ "$part_label" = "kernel1" ]
		then
			CI_UBIPART="rootfs1"
		else
			CI_UBIPART="rootfs2"
		fi

		nand_upgrade_tar "$1"
	}
	[ "$magic_long" = "27051956" -o "$magic_long" = "0000a0e1" ] && {
		# check firmwares' rootfs types
		local target_mtd=$(find_mtd_part $part_label)
		local oldroot="$(linksys_get_root_magic $target_mtd)"
		local newroot="$(linksys_get_root_magic "$1")"

		if [ "$newroot" = "55424923" -a "$oldroot" = "55424923" ]
		# we're upgrading from a firmware with UBI to one with UBI
		then
			# erase everything to be safe
			mtd erase $part_label
			get_image "$1" | mtd -n write - $part_label
		else
			get_image "$1" | mtd write - $part_label
		fi
	}
