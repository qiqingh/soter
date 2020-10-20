platform_do_upgrade() {
	local board=$(board_name)

	case "$board" in
	bananapi,bpi-r64-rootdisk)
		#2097152=0x200000 is the offset in bytes from the start
		#of eMMC and to the location of the kernel
		get_image "$1" | dd of=/dev/mmcblk0 bs=2097152 seek=1 conv=fsync
		;;
	mediatek,mt7622,ubi)
		nand_do_upgrade "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
}

PART_NAME=firmware

