	local dev=$(find_mtd_part 'mac')
	[ -z "$dev" ] && return

	# The revision is stored at the beginning of the "mac" partition
	local rev="$(LC_CTYPE=C awk -v 'FS=[^[:print:]]' '{print $1; exit}' $dev)"
	AR71XX_MODEL="D-Link DIR-505 rev. $rev"
