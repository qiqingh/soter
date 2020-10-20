	local fw_part=$1
	local fw_file=$2
	local fw_mtd=$(find_mtd_part $fw_part)
	local fw_length=0x$(dd if="$fw_file" bs=2 skip=1 count=4 2>/dev/null)
	local fw_blocks=$(($fw_length / 65536))

	if [ -n "$fw_mtd" ] &&  [ ${fw_blocks:-0} -gt 0 ]; then
		local append=""
		[ -f "$UPGRADE_BACKUP" ] && append="-j $UPGRADE_BACKUP"

		sync
		dd if="$fw_file" bs=64k skip=1 count=$fw_blocks 2>/dev/null | \
			mtd $append write - "$fw_part"
	fi
