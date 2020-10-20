	local disk="$1"
	local filename="$2"

	if [ -b "$disk" -o -f "$disk" ]; then
		v "Reading partition table from $filename..."

		local magic=$(dd if="$disk" bs=2 count=1 skip=255 2>/dev/null)
		if [ "$magic" != $'\x55\xAA' ]; then
			v "Invalid partition table on $disk"
			exit
		fi

		rm -f "/tmp/partmap.$filename"

		local part
		for part in 1 2 3 4; do
			set -- $(hexdump -v -n 12 -s "$((0x1B2 + $part * 16))" -e '3/4 "0x%08X "' "$disk")

			local type="$(( $(hex_le32_to_cpu $1) % 256))"
			local lba="$(( $(hex_le32_to_cpu $2) ))"
			local num="$(( $(hex_le32_to_cpu $3) ))"

			[ $type -gt 0 ] || continue

			printf "%2d %5d %7d\n" $part $lba $num >> "/tmp/partmap.$filename"
		done
	fi
