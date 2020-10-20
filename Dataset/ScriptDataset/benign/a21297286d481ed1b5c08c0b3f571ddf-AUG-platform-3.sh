	local machine=$(platform_machine)

	case "$machine" in
		"Netgear WGR614 V8")	echo "chk U12H072T00_NETGEAR"; return;;
		"Netgear WGR614 V9")	echo "chk U12H094T00_NETGEAR"; return;;
		"Netgear WGR614 V10")	echo "chk U12H139T01_NETGEAR"; return;;
		"Netgear WN2500RP V1")	echo "chk U12H197T00_NETGEAR"; return;;
		"Netgear WN2500RP V2")	echo "chk U12H294T00_NETGEAR"; return;;
		"Netgear WNDR3300")	echo "chk U12H093T00_NETGEAR"; return;;
		"Netgear WNDR3400 V1")	echo "chk U12H155T00_NETGEAR"; return;;
		"Netgear WNDR3400 V2")	echo "chk U12H187T00_NETGEAR"; return;;
		"Netgear WNDR3400 V3")	echo "chk U12H208T00_NETGEAR"; return;;
		"Netgear WNDR3400 Vcna")	echo "chk U12H155T01_NETGEAR"; return;;
		"Netgear WNDR3700 V3")	echo "chk U12H194T00_NETGEAR"; return;;
		"Netgear WNDR4000")	echo "chk U12H181T00_NETGEAR"; return;;
		"Netgear WNDR4500 V1")	echo "chk U12H189T00_NETGEAR"; return;;
		"Netgear WNDR4500 V2")	echo "chk U12H224T00_NETGEAR"; return;;
		"Netgear WNR2000 V2")	echo "chk U12H114T00_NETGEAR"; return;;
		"Netgear WNR3500L")	echo "chk U12H136T99_NETGEAR"; return;;
		"Netgear WNR3500U")	echo "chk U12H136T00_NETGEAR"; return;;
		"Netgear WNR3500 V2")	echo "chk U12H127T00_NETGEAR"; return;;
		"Netgear WNR3500 V2vc")	echo "chk U12H127T70_NETGEAR"; return;;
		"Netgear WNR834B V2")	echo "chk U12H081T00_NETGEAR"; return;;
		"Linksys E900 V1")	echo "cybertan E900"; return;;
		"Linksys E1000 V1")	echo "cybertan E100"; return;;
		"Linksys E1000 V2")	echo "cybertan E100"; return;;
		"Linksys E1000 V2.1")	echo "cybertan E100"; return;;
		"Linksys E1200 V2")	echo "cybertan E122"; return;;
		"Linksys E2000 V1")	echo "cybertan 32XN"; return;;
		"Linksys E3000 V1")	echo "cybertan 61XN"; return;;
		"Linksys E3200 V1")	echo "cybertan 3200"; return;;
		"Linksys E4200 V1")	echo "cybertan 4200"; return;;
		"Linksys WRT150N V1.1")	echo "cybertan N150"; return;;
		"Linksys WRT150N V1")	echo "cybertan N150"; return;;
		"Linksys WRT160N V1")	echo "cybertan N150"; return;;
		"Linksys WRT160N V3")	echo "cybertan N150"; return;;
		"Linksys WRT300N V1")	echo "cybertan EWCB"; return;;
		"Linksys WRT300N V1.1")	echo "cybertan EWC2"; return;;
		"Linksys WRT310N V1")	echo "cybertan 310N"; return;;
		"Linksys WRT310N V2")	echo "cybertan 310N"; return;;
		"Linksys WRT610N V1")	echo "cybertan 610N"; return;;
		"Linksys WRT610N V2")	echo "cybertan 610N"; return;;
	esac
