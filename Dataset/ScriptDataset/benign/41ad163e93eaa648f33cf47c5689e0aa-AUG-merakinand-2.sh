	local board=$1
	local mtddev=$2
	local magic

	case "$board" in
	"mr18")
		magic=$(get_magic_at $mtddev 4096)
		[ "$magic" != "0202" ] && return 0

		magic=$(get_magic_at $mtddev 20480)
		[ "$magic" != "0202" ] && return 0

		magic=$(get_magic_at $mtddev 36864)
		[ "$magic" != "0202" ] && return 0

		return 1
		;;
	"z1")
		magic=$(get_magic_at $mtddev 4096)
		[ "$magic" != "0202" ] && return 0

		magic=$(get_magic_at $mtddev 86016)
		[ "$magic" != "a55a" ] && return 0

		return 1
		;;
	*)
		return 1
		;;
	esac
