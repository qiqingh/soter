	local board=$(board_name)

	case "$board" in
	apalis*)
		[ -z "$UPGRADE_BACKUP" ] && {
			jffs2reset -y
			umount /overlay
		}
		;;
	esac
