	local mtddev=$1
	local magic

	magic=$(get_magic_at $mtddev 4096)
	[ "$magic" != "a55a" ] && return 0

	magic=$(get_magic_at $mtddev 20480)
	[ "$magic" != "a55a" ] && return 0

	return 1
