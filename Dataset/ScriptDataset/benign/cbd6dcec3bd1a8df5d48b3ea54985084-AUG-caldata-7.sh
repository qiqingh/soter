	local mac=$1
	local mac_offset=$(($2))
	local chksum_offset=$(($3))
	local xor_mac
	local xor_fw_mac
	local xor_fw_chksum

	xor_mac=${mac//:/}
	xor_mac="${xor_mac:0:4} ${xor_mac:4:4} ${xor_mac:8:4}"

	xor_fw_mac=$(hexdump -v -n 6 -s $mac_offset -e '/1 "%02x"' /lib/firmware/$FIRMWARE)
	xor_fw_mac="${xor_fw_mac:0:4} ${xor_fw_mac:4:4} ${xor_fw_mac:8:4}"

	xor_fw_chksum=$(hexdump -v -n 2 -s $chksum_offset -e '/1 "%02x"' /lib/firmware/$FIRMWARE)
	xor_fw_chksum=$(xor $xor_fw_chksum $xor_fw_mac $xor_mac)

	printf "%b" "\x${xor_fw_chksum:0:2}\x${xor_fw_chksum:2:2}" | \
		dd of=/lib/firmware/$FIRMWARE conv=notrunc bs=1 seek=$chksum_offset count=2
