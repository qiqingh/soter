	local fw_printenv=/usr/sbin/fw_printenv
	[ ! -n "$fw_printenv" -o ! -x "$fw_printenv" ] && {
		echo "Please install uboot-envtools!"
		return 1
	}

	[ ! -r "/etc/fw_env.config" ] && {
		echo "/etc/fw_env.config is missing"
		return 1
	}

	local image_size=$( get_filesize "$1" )
	local firmware_size=$( platform_get_firmware_size )
	[ $image_size -ge $firmware_size ] &&
	{
		echo "upgrade image is too big (${image_size}b > ${firmware_size}b)"
	}

	local vmlinux_blockoffset=$( platform_get_offset "$1" uImage )
	[ -z $vmlinux_blockoffset ] && {
		echo "vmlinux-uImage not found"
		return 1
	}

	local rootfs_blockoffset=$( platform_get_offset "$1" rootfs "$vmlinux_blockoffset" )
	[ -z $rootfs_blockoffset ] && {
		echo "missing rootfs"
		return 1
	}

	local data_blockoffset=$( platform_get_offset "$1" rootfs-data "$rootfs_blockoffset" )
	[ -z $data_blockoffset ] && {
		echo "rootfs doesn't have JFFS2 end marker"
		return 1
	}

	return 0
