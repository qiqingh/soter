	local board=$(board_name)

	case "$board" in
	all0258n)
		platform_do_upgrade_allnet "0x9f050000" "$ARGV"
		;;
	all0305|\
	eap7660d|\
	ja76pf|\
	ja76pf2|\
	jwap003|\
	ls-sr71|\
	pb42|\
	pb44|\
	routerstation|\
	routerstation-pro)
		platform_do_upgrade_combined "$ARGV"
		;;
	all0315n)
		platform_do_upgrade_allnet "0x9f080000" "$ARGV"
		;;
	cap4200ag|\
	eap300v2|\
	ens202ext)
		platform_do_upgrade_allnet "0xbf0a0000" "$ARGV"
		;;
	dir-825-b1|\
	tew-673gru)
		platform_do_upgrade_dir825b "$ARGV"
		;;
	a40|\
	a60|\
	mr1750|\
	mr1750v2|\
	mr600|\
	mr600v2|\
	mr900|\
	mr900v2|\
	om2p|\
	om2p-hs|\
	om2p-hsv2|\
	om2p-hsv3|\
	om2p-hsv4|\
	om2p-lc|\
	om2pv2|\
	om2pv4|\
	om5p|\
	om5p-ac|\
	om5p-acv2|\
	om5p-an)
		platform_do_upgrade_openmesh "$ARGV"
		;;
	c-60|\
	hiveap-121|\
	nbg6716|\
	r6100|\
	rambutan|\
	rb-411|\
	rb-411u|\
	rb-433|\
	rb-433u|\
	rb-435g|\
	rb-450|\
	rb-450g|\
	rb-493|\
	rb-493g|\
	rb-750|\
	rb-750gl|\
	rb-751|\
	rb-751g|\
	rb-911g-2hpnd|\
	rb-911g-5hpacd|\
	rb-911g-5hpnd|\
	rb-912uag-2hpnd|\
	rb-912uag-5hpnd|\
	rb-921gs-5hpacd-r2|\
	rb-922uags-5hpacd|\
	rb-951g-2hnd|\
	rb-951ui-2hnd|\
	rb-2011il|\
	rb-2011ils|\
	rb-2011l|\
	rb-2011uas|\
	rb-2011uas-2hnd|\
	rb-2011uias|\
	rb-2011uias-2hnd|\
	rb-2011uias-2hnd-r2|\
	rb-sxt2n|\
	rb-sxt5n|\
	wi2a-ac200i|\
	wndr3700v4|\
	wndr4300)
		nand_do_upgrade "$1"
		;;
	mr18|\
	z1)
		merakinand_do_upgrade "$1"
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
