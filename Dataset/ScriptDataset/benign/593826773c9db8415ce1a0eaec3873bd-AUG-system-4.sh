	local mtdname="$1"
	local offset="$2"

	. /lib/upgrade/nand.sh

	local ubidev=$(nand_find_ubi $CI_UBIPART)
	local part=$(nand_find_volume $ubidev $1)

	if [ -z "$part" ]; then
		echo "mtd_get_mac_binary: ubi volume $mtdname not found!" >&2
		return
	fi

	hexdump -v -n 6 -s $offset -e '5/1 "%02x:" 1/1 "%02x"' /dev/$part 2>/dev/null
