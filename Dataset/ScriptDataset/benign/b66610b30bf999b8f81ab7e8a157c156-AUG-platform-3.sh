	local board=$(ipq806x_board_name)

	case "$board" in
	c2600)
		PART_NAME="os-image:rootfs"
		MTD_CONFIG_ARGS="-s 0x200000"
		default_do_upgrade "$ARGV"
		;;
	ea8500)
		platform_do_upgrade_linksys "$ARGV"
		;;
	vr2600v)
		PART_NAME="kernel:rootfs"
		MTD_CONFIG_ARGS="-s 0x200000"
		default_do_upgrade "$ARGV"
		;;
	esac
