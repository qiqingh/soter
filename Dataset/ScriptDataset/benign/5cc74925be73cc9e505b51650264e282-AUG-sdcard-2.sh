	local board=$(board_name)
	local diskdev partdev diff

	export_bootdevice && export_partdevice diskdev 0 || {
		echo "Unable to determine upgrade device"
	return 1
	}

	sync

	if [ "$UPGRADE_OPT_SAVE_PARTITIONS" = "1" ]; then
		get_partitions "/dev/$diskdev" bootdisk

		#extract the boot sector from the image
		get_image "$@" | dd of=/tmp/image.bs count=1 bs=512b

		get_partitions /tmp/image.bs image

		#compare tables
		diff="$(grep -F -x -v -f /tmp/partmap.bootdisk /tmp/partmap.image)"
	else
		diff=1
	fi

	if [ -n "$diff" ]; then
		get_image "$@" | dd of="/dev/$diskdev" bs=4096 conv=fsync

		# Separate removal and addtion is necessary; otherwise, partition 1
		# will be missing if it overlaps with the old partition 2
		partx -d - "/dev/$diskdev"
		partx -a - "/dev/$diskdev"
	else
		#write uboot image
		get_image "$@" | dd of="$diskdev" bs=512 skip=1 seek=1 count=2048 conv=fsync
		#iterate over each partition from the image and write it to the boot disk
		while read part start size; do
			if export_partdevice partdev $part; then
				echo "Writing image to /dev/$partdev..."
				get_image "$@" | dd of="/dev/$partdev" ibs="512" obs=1M skip="$start" count="$size" conv=fsync
			else
				echo "Unable to find partition $part device, skipped."
			fi
		done < /tmp/partmap.image

		#copy partition uuid
		echo "Writing new UUID to /dev/$diskdev..."
		get_image "$@" | dd of="/dev/$diskdev" bs=1 skip=440 count=4 seek=440 conv=fsync
	fi

	case "$board" in
	cznic,turris-omnia)
		fw_setenv openwrt_bootargs 'earlyprintk console=ttyS0,115200 root=/dev/mmcblk0p2 rootfstype=auto rootwait'
		fw_setenv openwrt_mmcload 'setenv bootargs "$openwrt_bootargs cfg80211.freg=$regdomain"; fatload mmc 0 0x01000000 zImage; fatload mmc 0 0x02000000 armada-385-turris-omnia.dtb'
		fw_setenv factory_mmcload 'setenv bootargs "$bootargs cfg80211.freg=$regdomain"; btrload mmc 0 0x01000000 boot/zImage @; btrload mmc 0 0x02000000 boot/dtb @'
		fw_setenv mmcboot 'run openwrt_mmcload || run factory_mmcload; bootz 0x01000000 - 0x02000000'
		;;
	esac

	sleep 1
