	local img_magic=$1
	local img_path=$2
	local fw_setenv=/usr/sbin/fw_setenv
	local img_board_target= img_num_files= i=0
	local cfg_name= kernel_name= rootfs_name=

	case "$img_magic" in
		# Combined Extended Image v1
		43453031)
			img_board_target=$(trim $(dd if="$img_path" bs=4 skip=1 count=8 2>/dev/null))
			img_num_files=$(trim $(dd if="$img_path" bs=2 skip=18 count=1 2>/dev/null))
			;;
		*)
			echo "Invalid image ($img_magic). Use combined extended images on this platform"
			return 1
			;;
	esac

	platform_check_image_target_openmesh "$img_board_target" || return 1

	[ $img_num_files -lt 3 ] && {
		echo "Invalid number of embedded images ($img_num_files). Use the correct image for this platform"
		return 1
	}

	cfg_name=$(trim $(dd if="$img_path" bs=2 skip=19 count=16 2>/dev/null))

	[ "$cfg_name" != "fwupgrade.cfg" ] && {
		echo "Invalid embedded config file ($cfg_name). Use the correct image for this platform"
		return 1
	}

	kernel_name=$(trim $(dd if="$img_path" bs=2 skip=55 count=16 2>/dev/null))

	[ "$kernel_name" != "kernel" ] && {
		echo "Invalid embedded kernel file ($kernel_name). Use the correct image for this platform"
		return 1
	}

	rootfs_name=$(trim $(dd if="$img_path" bs=2 skip=91 count=16 2>/dev/null))

	[ "$rootfs_name" != "rootfs" ] && {
		echo "Invalid embedded kernel file ($rootfs_name). Use the correct image for this platform"
		return 1
	}

	[ ! -x "$fw_setenv" ] && {
		echo "Please install uboot-envtools!"
		return 1
	}

	[ ! -r "/etc/fw_env.config" ] && {
		echo "/etc/fw_env.config is missing"
		return 1
	}

	return 0
