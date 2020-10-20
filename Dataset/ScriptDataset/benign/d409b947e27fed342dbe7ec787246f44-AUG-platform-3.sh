	local board=$(board_name)

	case "$board" in
	adtran,bsap1800-v2|\
	adtran,bsap1840)
		redboot_fis_do_upgrade "$1" vmlinux_2
		;;
	jjplus,ja76pf2)
		echo "Sysupgrade disabled due bug FS#2428"
		;;
	ubnt,routerstation|\
	ubnt,routerstation-pro)
		echo "Sysupgrade disabled due bug FS#2428"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
