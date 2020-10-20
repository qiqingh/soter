	local file="$1"
	local magic

	magic=$(get_magic_at "$file" 510)
	[ "$magic" != "55aa" ] && {
		echo "Failed to verify MBR boot signature."
		return 1
	}

	return 0;
