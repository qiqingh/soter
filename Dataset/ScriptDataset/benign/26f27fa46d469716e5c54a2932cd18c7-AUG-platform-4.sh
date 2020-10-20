	case "$(board_name)" in
	alfa-network,ap120c-ac)
		part="$(awk -F 'ubi.mtd=' '{printf $2}' /proc/cmdline | sed -e 's/ .*$//')"
		if [ "$part" = "rootfs1" ]; then
			fw_setenv active 2 || exit 1
			CI_UBIPART="rootfs2"
		else
			fw_setenv active 1 || exit 1
			CI_UBIPART="rootfs1"
		fi
		;;
	asus,rt-ac58u)
		CI_UBIPART="UBI_DEV"
		CI_KERNPART="linux"
		;;
	meraki,mr33)
		CI_KERNPART="part.safe"
		;;
	esac
