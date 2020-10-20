	local board=$(ar71xx_board_name)

	case "$board" in
	rb*) echo "routerboard";;
	*) echo "$board";;
	esac
