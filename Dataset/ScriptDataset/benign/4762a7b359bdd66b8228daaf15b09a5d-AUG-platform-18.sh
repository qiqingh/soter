	local board=$(board_name)

	case "$board" in
	rb*)
		CI_KERNPART=none
		local fw_mtd=$(find_mtd_part kernel)
		fw_mtd="${fw_mtd/block/}"
		[ -n "$fw_mtd" ] || return

		local board_dir=$(tar tf "$1" | grep -m 1 '^sysupgrade-.*/$')
		board_dir=${board_dir%/}
		[ -n "$board_dir" ] || return

		mtd erase kernel
		tar xf "$1" ${board_dir}/kernel -O | nandwrite -o "$fw_mtd" -
		;;
	wi2a-ac200i)
		case "$(fw_printenv -n dualPartition)" in
			imgA)
				fw_setenv dualPartition imgB
				fw_setenv ActImg NokiaImageB
			;;
			imgB)
				fw_setenv dualPartition imgA
				fw_setenv ActImg NokiaImageA
			;;
		esac
		ubiblock -r /dev/ubiblock0_0 2>/dev/null >/dev/null
		rm -f /dev/ubiblock0_0
		ubidetach -d 0 2>/dev/null >/dev/null
		CI_UBIPART=ubi_alt
		CI_KERNPART=kernel_alt
		;;
	esac
