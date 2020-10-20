	local cal_src=$1
	local cal_dst=$2
	local ubidev="$(nand_find_ubi $CI_UBIPART)"
	local board_name="$(cat /tmp/sysinfo/board_name)"
	local rootfs_size="$(ubinfo /dev/ubi0 -N rootfs_data | grep "Size" | awk '{ print $6 }')"

	# Setup partitions using board name, in case of future platforms
	case "$board_name" in
	"mr18"|\
	"z1")
		# Src is MTD
		mtd_src="$(find_mtd_chardev $cal_src)"
		[ -n "$mtd_src" ] || {
			echo "no mtd device found for partition $cal_src"
			exit 1
		}

		# Dest is UBI
		# TODO: possibly add create (hard to do when rootfs_data is expanded & mounted)
		# Would need to be done from ramdisk
		mtd_dst="$(nand_find_volume $ubidev $cal_dst)"
		[ -n "$mtd_dst" ] || {
			echo "no ubi device found for partition $cal_dst"
			exit 1
		}

		meraki_is_caldata_valid "$board_name" "$mtd_src" && {
			echo "no valid calibration data found in $cal_src"
			exit 1
		}

		meraki_is_caldata_valid "$board_name" "/dev/$mtd_dst" && {
			echo "Copying calibration data from $cal_src to $cal_dst..."
			dd if="$mtd_src" of=/tmp/caldata.tmp 2>/dev/null
			ubiupdatevol "/dev/$mtd_dst" /tmp/caldata.tmp
			rm /tmp/caldata.tmp
			sync
		}
		return 0
		;;
	*)
		echo "Unsupported device $board_name";
		return 1
		;;
	esac
