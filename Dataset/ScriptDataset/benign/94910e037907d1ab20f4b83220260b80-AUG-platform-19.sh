	local board=$(ar71xx_board_name)

	case "$board" in
	rb-941-2nd)
		PLATFORM_DO_UPGRADE_COMBINED_SEPARATE_MTD=1
		platform_do_upgrade_combined "$ARGV"
		;;
	all0258n)
		platform_do_upgrade_allnet "0x9f050000" "$ARGV"
		;;
	all0305|\
	eap7660d|\
	ja76pf2|\
	ja76pf|\
	jwap003|\
	ls-sr71|\
	pb42|\
	pb44|\
	routerstation-pro|\
	routerstation)
		platform_do_upgrade_combined "$ARGV"
		;;
	all0315n)
		platform_do_upgrade_allnet "0x9f080000" "$ARGV"
		;;
	cap4200ag|\
	eap300v2)
		platform_do_upgrade_allnet "0xbf0a0000" "$ARGV"
		;;
	dir-825-b1|\
	tew-673gru)
		platform_do_upgrade_dir825b "$ARGV"
		;;
	mr1750v2|\
	mr1750|\
	mr600v2|\
	mr600|\
	mr900v2|\
	mr900|\
	om2p-hsv2|\
	om2p-hsv3|\
	om2p-hs|\
	om2p-lc|\
	om2pv2|\
	om2p|\
	om5p-acv2|\
	om5p-ac|\
	om5p-an|\
	om5p)
		platform_do_upgrade_openmesh "$ARGV"
		;;
	uap-pro|\
	unifi-outdoor-plus)
		MTD_CONFIG_ARGS="-s 0x180000"
		default_do_upgrade "$ARGV"
		;;
	wp543|\
	wpe72)
		platform_do_upgrade_compex "$ARGV"
		;;
	*)
		default_do_upgrade "$ARGV"
		;;
	esac
