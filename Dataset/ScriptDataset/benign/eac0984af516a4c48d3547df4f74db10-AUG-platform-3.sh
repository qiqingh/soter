	local board=$(mvebu_board_name)

	case "$board" in
	armada-388-clearfog)
		platform_copy_config_clearfog "$ARGV"
		;;
	esac
