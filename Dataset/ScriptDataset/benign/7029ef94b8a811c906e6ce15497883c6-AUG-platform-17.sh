	local board=$(board_name)

	case "$board" in
	rb-750-r2|\
	rb-750p-pbr2|\
	rb-750up-r2|\
	rb-911-2hn|\
	rb-911-5hn|\
	rb-941-2nd|\
	rb-951ui-2nd|\
	rb-952ui-5ac2nd|\
	rb-962uigs-5hact2hnt|\
	rb-lhg-5nd|\
	rb-map-2nd|\
	rb-mapl-2nd|\
	rb-wap-2nd|\
	rb-wapg-5hact2hnd)
		# erase firmware if booted from initramfs
		[ -z "$(rootfs_type)" ] && mtd erase firmware
		;;
	esac
