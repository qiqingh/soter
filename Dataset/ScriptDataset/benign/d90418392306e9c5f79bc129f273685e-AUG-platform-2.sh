	mtd erase kernel
	tar xf "$1" "sysupgrade-$(board_name)/kernel" -O | nandwrite -o /dev/mtd0 -
	nand_do_upgrade "$1"
