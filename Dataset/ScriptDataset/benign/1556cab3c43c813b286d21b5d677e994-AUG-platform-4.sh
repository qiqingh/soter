	local machine=$(platform_machine)

	case "$machine" in
		"dlink,dir-885l")	echo "seama wrgac42_dlink.2015_dir885l"; return;;
		"netgear,r6250v1")	echo "chk U12H245T00_NETGEAR"; return;;
		"netgear,r6300v2")	echo "chk U12H240T00_NETGEAR"; return;;
		"netgear,r7000")	echo "chk U12H270T00_NETGEAR"; return;;
		"netgear,r7900")	echo "chk U12H315T30_NETGEAR"; return;;
		"netgear,r8000")	echo "chk U12H315T00_NETGEAR"; return;;
		"netgear,r8500")	echo "chk U12H334T00_NETGEAR"; return;;
		"tplink,archer-c9-v1")	echo "safeloader"; return;;
	esac
