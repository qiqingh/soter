	local magic

	magic=$(get_magic_long "$1")
	case "$magic" in
		"48445230")
			echo "trx"
			return
			;;
		"2a23245e")
			echo "chk"
			return
			;;
		"4c584c23")
			echo "lxl"
			return
			;;
		"5ea3a417")
			echo "seama"
			return
			;;
	esac

	magic=$(get_magic_long_at "$1" 14)
	[ "$magic" = "55324e44" ] && {
		echo "cybertan"
		return
	}

	magic=$(get_magic_long_at "$1" 60)
	[ "$magic" = "4c584c23" ] && {
		echo "lxlold"
		return
	}

	if osafeloader info "$1" > /dev/null 2>&1; then
		echo "safeloader"
		return
	fi

	echo "unknown"
