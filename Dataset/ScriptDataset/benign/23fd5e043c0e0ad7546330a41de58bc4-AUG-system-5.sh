	local INDEX=$(find_mtd_index "$1")
	local PREFIX=/dev/mtd

	[ -d /dev/mtd ] && PREFIX=/dev/mtd/
	echo "${INDEX:+$PREFIX$INDEX}"
