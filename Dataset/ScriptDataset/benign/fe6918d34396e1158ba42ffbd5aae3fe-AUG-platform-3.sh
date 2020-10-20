	local first dev size erasesize name
	while read dev size erasesize name; do
		name=${name#'"'}; name=${name%'"'}
		[ "$name" = "$1" ] && {
			echo "$size"
			break
		}
	done < /proc/mtd
