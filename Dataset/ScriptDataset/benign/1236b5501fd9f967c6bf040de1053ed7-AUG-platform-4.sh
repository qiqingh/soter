	case "$(board_name)" in
	8dev,jalapeno |\
	aruba,ap-303 |\
	aruba,ap-303h |\
	aruba,ap-365 |\
	avm,fritzbox-7530 |\
	avm,fritzrepeater-1200 |\
	avm,fritzrepeater-3000 |\
	buffalo,wtr-m2133hp |\
	cilab,meshpoint-one |\
	engenius,eap2200 |\
	mobipromo,cm520-79f |\
	qxwlan,e2600ac-c2)
		nand_do_upgrade "$1"
		;;
	alfa-network,ap120c-ac)
		part="$(awk -F 'ubi.mtd=' '{printf $2}' /proc/cmdline | sed -e 's/ .*$//')"
		if [ "$part" = "rootfs1" ]; then
			fw_setenv active 2 || exit 1
			CI_UBIPART="rootfs2"
		else
			fw_setenv active 1 || exit 1
			CI_UBIPART="rootfs1"
		fi
		nand_do_upgrade "$1"
		;;
	asus,map-ac2200)
		CI_KERNPART="linux"
		nand_do_upgrade "$1"
		;;
	asus,rt-ac58u)
		CI_UBIPART="UBI_DEV"
		CI_KERNPART="linux"
		nand_do_upgrade "$1"
		;;
	cellc,rtl30vw)
		CI_UBIPART="ubifs"
		askey_do_upgrade "$1"
		;;
	compex,wpj419)
		nand_do_upgrade "$1"
		;;
	linksys,ea6350v3 |\
	linksys,ea8300)
		platform_do_upgrade_linksys "$1"
		;;
	meraki,mr33)
		CI_KERNPART="part.safe"
		nand_do_upgrade "$1"
		;;
	openmesh,a42 |\
	openmesh,a62)
		PART_NAME="inactive"
		platform_do_upgrade_openmesh "$1"
		;;
	zyxel,nbg6617)
		zyxel_do_upgrade "$1"
		;;
	*)
		default_do_upgrade "$1"
		;;
	esac
