	local board=$(board_name)

	case "$board" in
	alfa-network,ac1200rm|\
	alfa-network,awusfree1|\
	alfa-network,quad-e4g|\
	alfa-network,r36m-e4g|\
	alfa-network,tube-e4g)
		[ "$(fw_printenv -n dual_image 2>/dev/null)" = "1" ] &&\
		[ -n "$(find_mtd_part backup)" ] && {
			PART_NAME=backup
			if [ "$(fw_printenv -n bootactive 2>/dev/null)" = "1" ]; then
				fw_setenv bootactive 2 || exit 1
			else
				fw_setenv bootactive 1 || exit 1
			fi
		}
		default_do_upgrade "$1"
		;;
	hc5962|\
	r6220|\
	netgear,r6350|\
	ubnt-erx|\
	ubnt-erx-sfp|\
	xiaomi,mir3g|\
	xiaomi,mir3p)
		nand_do_upgrade "$1"
		;;
	tplink,c50-v4)
		MTD_ARGS="-t romfile"
		default_do_upgrade "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
