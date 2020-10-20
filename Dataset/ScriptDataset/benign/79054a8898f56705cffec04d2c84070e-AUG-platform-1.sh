	local magic="$(get_magic_word "$1")"

	[ "$#" -gt 1 ] && return 1

	case "$board_name" in
	"ZyXEL"*|"Compex WP54 family")
		# .trx files
		[ "$magic" != "4844" ] && {
			echo "Invalid image type."
			return 1
		}
		return 0
		;;
	*)
		;;
	esac

	echo "Sysupgrade is not yet supported on $board_name."
	return 1
