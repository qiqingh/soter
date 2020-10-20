	local mac=$1
	local mac_offset=$(($2))
	local chksum_offset=$3

	[ -z "$mac" -o -z "$mac_offset" ] && return

	[ -n "$chksum_offset" ] && caldata_patch_chksum "$mac" "$mac_offset" "$chksum_offset"

	macaddr_2bin $mac | dd of=/lib/firmware/$FIRMWARE conv=notrunc oflag=seek_bytes bs=6 seek=$mac_offset count=1 || \
		caldata_die "failed to write MAC address to eeprom file"
