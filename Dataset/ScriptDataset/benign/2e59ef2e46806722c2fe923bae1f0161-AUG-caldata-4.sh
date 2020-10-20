	local part=$1
	local offset=$2
	local count=$(($3))
	local mtd
	local reversed
	local caldata

	mtd=$(find_mtd_chardev "$part")
	reversed=$(hexdump -v -s $offset -n $count -e '/1 "%02x "' $mtd)

	for byte in $reversed; do
		caldata="\x${byte}${caldata}"
	done

	printf "%b" "$caldata" > /lib/firmware/$FIRMWARE
