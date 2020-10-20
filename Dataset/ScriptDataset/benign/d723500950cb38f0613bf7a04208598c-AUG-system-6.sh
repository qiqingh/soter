	local mtdname="$1"
	local offset="$2"

	. /lib/upgrade/nand.sh

	local ubidev=$(nand_find_ubi $CI_UBIPART)
	local part=$(nand_find_volume $ubidev $1)

	get_mac_binary "/dev/$part" "$offset"
