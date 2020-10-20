	local dev size erasesize name
	while read dev size erasesize name; do
		name=${name#'"'}; name=${name%'"'}
		case "$name" in
			firmware)
				printf "%d" "0x$size"
				break
			;;
		esac
	done < /proc/mtd
