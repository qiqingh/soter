	local tar_file="$1"
	local board=$(cat /tmp/sysinfo/board_name)
	local rootfs="$(zyxel_get_rootfs)"
	local kernel=

	[ -b "${rootfs}" ] || return 1
	case "$board" in
	nbg6817)
		kernel=mmcblk0p4
		;;
	*)
		return 1
	esac

	zyxel_do_flash $tar_file $board $kernel $rootfs

	return 0
