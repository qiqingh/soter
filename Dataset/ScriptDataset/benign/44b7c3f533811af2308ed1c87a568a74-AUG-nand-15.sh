	local file_type=$(identify $1)

	[ ! "$(find_mtd_index "$CI_UBIPART")" ] && CI_UBIPART="rootfs"

	case "$file_type" in
		"ubi")		nand_upgrade_ubinized $1;;
		"ubifs")	nand_upgrade_ubifs $1;;
		*)		nand_upgrade_tar $1;;
	esac
