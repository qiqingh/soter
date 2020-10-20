	local machine=$(board_name)

	case "$machine" in
		"dlink,dir-885l")	echo "seama wrgac42_dlink.2015_dir885l"; return;;
		"luxul,abr-4500-v1")	echo "lxl ABR-4500"; return;;
		"luxul,xap-810-v1")	echo "lxl XAP-810"; return;;
		"luxul,xap-1410v1")	echo "lxl XAP-1410"; return;;
		"luxul,xap-1440-v1")	echo "lxl XAP-1440"; return;;
		"luxul,xap-1510v1")	echo "lxl XAP-1510"; return;;
		"luxul,xap-1610-v1")	echo "lxl XAP-1610"; return;;
		"luxul,xbr-4500-v1")	echo "lxl XBR-4500"; return;;
		"luxul,xwc-1000")	echo "lxl XWC-1000"; return;;
		"luxul,xwc-2000-v1")	echo "lxl XWC-2000"; return;;
		"luxul,xwr-1200v1")	echo "lxl XWR-1200"; return;;
		"luxul,xwr-3100v1")	echo "lxl XWR-3100"; return;;
		"luxul,xwr-3150-v1")	echo "lxl XWR-3150"; return;;
		"netgear,r6250v1")	echo "chk U12H245T00_NETGEAR"; return;;
		"netgear,r6300v2")	echo "chk U12H240T00_NETGEAR"; return;;
		"netgear,r7000")	echo "chk U12H270T00_NETGEAR"; return;;
		"netgear,r7900")	echo "chk U12H315T30_NETGEAR"; return;;
		"netgear,r8000")	echo "chk U12H315T00_NETGEAR"; return;;
		"netgear,r8500")	echo "chk U12H334T00_NETGEAR"; return;;
		"tplink,archer-c9-v1")	echo "safeloader"; return;;
	esac
