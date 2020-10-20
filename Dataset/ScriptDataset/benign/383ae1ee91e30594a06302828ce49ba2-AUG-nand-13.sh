	local rootfs_length=$( (cat $1 | wc -c) 2> /dev/null)

	nand_upgrade_prepare_ubi "$rootfs_length" "ubifs" "0" "0"

	local ubidev="$( nand_find_ubi "$CI_UBIPART" )"
	local root_ubivol="$(nand_find_volume $ubidev $CI_ROOTPART)"
	ubiupdatevol /dev/$root_ubivol -s $rootfs_length $1

	nand_do_upgrade_success
