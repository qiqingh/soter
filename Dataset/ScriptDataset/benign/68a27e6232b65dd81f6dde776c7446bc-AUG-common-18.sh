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
		part_magic_efi "$disk" && {
			#export_partdevice will fail when partition number is greater than 15, as
			#the partition major device number is not equal to the disk major device number
			for part in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do
				set -- $(hexdump -v -n 48 -s "$((0x380 + $part * 0x80))" -e '4/4 "%08x"" "4/4 "%08x"" "4/4 "0x%08X "' "$disk")

				local type="$1"
				local lba="$(( $(hex_le32_to_cpu $4) * 0x100000000 + $(hex_le32_to_cpu $3) ))"
				local end="$(( $(hex_le32_to_cpu $6) * 0x100000000 + $(hex_le32_to_cpu $5) ))"
				local num="$(( $end - $lba ))"

				[ "$type" = "00000000000000000000000000000000" ] && continue

				printf "%2d %5d %7d\n" $part $lba $num >> "/tmp/partmap.$filename"
			done
		} || {
			for part in 1 2 3 4; do
				set -- $(hexdump -v -n 12 -s "$((0x1B2 + $part * 16))" -e '3/4 "0x%08X "' "$disk")

				local type="$(( $(hex_le32_to_cpu $1) % 256))"
				local lba="$(( $(hex_le32_to_cpu $2) ))"
				local num="$(( $(hex_le32_to_cpu $3) ))"

				[ $type -gt 0 ] || continue

				printf "%2d %5d %7d\n" $part $lba $num >> "/tmp/partmap.$filename"
			done
		}
	fi
