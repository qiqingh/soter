	local disk="$1"
	local filename="$2"

	if [ -b "$disk" -o -f "$disk" ]; then
		v "Reading partition table from $filename..."

		local magic="$(hexdump -v -n 2 -s 0x1FE -e '1/2 "0x%04X"' "$disk")"
		if [ "$magic" != 0xAA55 ]; then
			v "Invalid partition table on $disk"
			exit
		fi

		rm -f "/tmp/partmap.$filename"

		local part
		for part in 1 2 3 4; do
			set -- $(hexdump -v -n 12 -s "$((0x1B2 + $part * 16))" -e '3/4 "0x%08X "' "$disk")

			local type="$(($1 % 256))"
			local lba="$(($2))"
			local num="$(($3))"

			[ $type -gt 0 ] || continue

			printf "%2d %5d %7d\n" $part $lba $num >> "/tmp/partmap.$filename"
		done
	fi
