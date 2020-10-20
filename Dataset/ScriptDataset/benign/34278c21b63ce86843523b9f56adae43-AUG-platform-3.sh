	local board_name="$(cat /tmp/sysinfo/board_name)"

	mtd erase kernel
	tar xf "$1" sysupgrade-$board_name/kernel -O | nandwrite -o /dev/mtd0 -
