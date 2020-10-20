	local magic="$(get_magic_long "$1")"

	[ "$#" -gt 1 ] && return 1

	[ "$magic" != "27051956" ] && {
		echo "Invalid image type."
		return 1
	}
	return 0
