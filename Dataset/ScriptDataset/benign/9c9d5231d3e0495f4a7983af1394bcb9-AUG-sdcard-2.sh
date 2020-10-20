	local board=$(board_name)

	sync
	get_image "$1" | dd of=/dev/mmcblk0 bs=2M conv=fsync

	case "$board" in
	armada-385-turris-omnia)
		fw_setenv openwrt_bootargs 'earlyprintk console=ttyS0,115200 root=/dev/mmcblk0p2 rootfstype=auto rootwait'
		fw_setenv openwrt_mmcload 'setenv bootargs "$openwrt_bootargs cfg80211.freg=$regdomain"; fatload mmc 0 0x01000000 zImage; fatload mmc 0 0x02000000 armada-385-turris-omnia.dtb'
		fw_setenv factory_mmcload 'setenv bootargs "$bootargs cfg80211.freg=$regdomain"; btrload mmc 0 0x01000000 boot/zImage @; btrload mmc 0 0x02000000 boot/dtb @'
		fw_setenv mmcboot 'run openwrt_mmcload || run factory_mmcload; bootz 0x01000000 - 0x02000000'
		;;
	esac

	sleep 1
