	img_board_target="$1"

	case "$img_board_target" in
		A60)
			[ "$board" = "a40" ] && return 0
			[ "$board" = "a60" ] && return 0
			echo "Invalid image board target ($img_board_target) for this platform: $board. Use the correct image for this platform"
			return 1
			;;
		OM2P)
			[ "$board" = "om2p" ] && return 0
			[ "$board" = "om2pv2" ] && return 0
			[ "$board" = "om2pv4" ] && return 0
			[ "$board" = "om2p-lc" ] && return 0
			[ "$board" = "om2p-hs" ] && return 0
			[ "$board" = "om2p-hsv2" ] && return 0
			[ "$board" = "om2p-hsv3" ] && return 0
			[ "$board" = "om2p-hsv4" ] && return 0
			echo "Invalid image board target ($img_board_target) for this platform: $board. Use the correct image for this platform"
			return 1
			;;
		OM5P)
			[ "$board" = "om5p" ] && return 0
			[ "$board" = "om5p-an" ] && return 0
			echo "Invalid image board target ($img_board_target) for this platform: $board. Use the correct image for this platform"
			return 1
			;;
		OM5PAC)
			[ "$board" = "om5p-ac" ] && return 0
			[ "$board" = "om5p-acv2" ] && return 0
			echo "Invalid image board target ($img_board_target) for this platform: $board. Use the correct image for this platform"
			return 1
			;;
		MR1750)
			[ "$board" = "mr1750" ] && return 0
			[ "$board" = "mr1750v2" ] && return 0
			echo "Invalid image board target ($img_board_target) for this platform: $board. Use the correct image for this platform"
			return 1
			;;
		MR600)
			[ "$board" = "mr600" ] && return 0
			[ "$board" = "mr600v2" ] && return 0
			echo "Invalid image board target ($img_board_target) for this platform: $board. Use the correct image for this platform"
			return 1
			;;
		MR900)
			[ "$board" = "mr900" ] && return 0
			[ "$board" = "mr900v2" ] && return 0
			echo "Invalid image board target ($img_board_target) for this platform: $board. Use the correct image for this platform"
			return 1
			;;
		*)
			echo "Invalid board target ($img_board_target). Use the correct image for this platform"
			return 1
			;;
	esac
