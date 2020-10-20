platform_do_upgrade() {                 
	local board=$(board_name)
	case "$board" in
	"unielec,u7623"*)
		#Keep the persisten random mac address (if it exists)
		mkdir -p /tmp/recovery
		mount -o rw,noatime /dev/mmcblk0p1 /tmp/recovery
		[ -f "/tmp/recovery/mac_addr" ] && \
			mv -f /tmp/recovery/mac_addr /tmp/
		umount /tmp/recovery

		#1310720 is the offset in bytes from the start of eMMC and to
		#the location of the kernel (2560 512 byte sectors)
		get_image "$1" | dd of=/dev/mmcblk0 bs=1310720 seek=1 conv=fsync

		mount -o rw,noatime /dev/mmcblk0p1 /tmp/recovery
		[ -f "/tmp/mac_addr" ] && mv -f /tmp/mac_addr /tmp/recovery
		sync
		umount /tmp/recovery
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
}

PART_NAME=firmware

