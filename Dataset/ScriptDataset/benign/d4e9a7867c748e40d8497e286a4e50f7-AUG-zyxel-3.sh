	local tar_file="$1"
	local board=$(board_name)
	local rootfs="$(zyxel_get_rootfs)"
	local kernel=

	[ -b "${rootfs}" ] || return 1
	case "$board" in
	zyxel,nbg6817)
		local dualflagmtd="$(find_mtd_part 0:DUAL_FLAG)"
		[ -b $dualflagmtd ] || return 1

		case "$rootfs" in
			"/dev/mmcblk0p5")
				# booted from the primary partition set
				# write to the alternative set
				kernel="/dev/mmcblk0p7"
				rootfs="/dev/mmcblk0p8"
			;;
			"/dev/mmcblk0p8")
				# booted from the alternative partition set
				# write to the primary set
				kernel="/dev/mmcblk0p4"
				rootfs="/dev/mmcblk0p5"
			;;
			*)
				return 1
			;;
		esac
		;;
	*)
		return 1
		;;
	esac

	zyxel_do_flash $tar_file $kernel $rootfs $dualflagmtd

	return 0
