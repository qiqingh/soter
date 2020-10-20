	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	OPMODE=0
	SYSCFG_NETWORK_MODE=""
	if [ "Extender" = "$DEVICE_TYPE" ]; then
		if [ ! -z "$EXTENDER_RADIO_MODE" ] && [ $EXTENDER_RADIO_MODE = "1" ]; then
			SYSCFG_NETWORK_MODE=`syscfg_get wl1_network_mode`
		else
			SYSCFG_NETWORK_MODE=`syscfg_get wl0_network_mode`
		fi
		SYSCFG_INDEX=wl"$EXTENDER_RADIO_MODE"
	else
		SYSCFG_NETWORK_MODE=`syscfg_get "$SYSCFG_INDEX"_network_mode`
	fi
	case "$SYSCFG_NETWORK_MODE" in
		"11a")
			OPMODE="$NET_A_ONLY"
			;;
		"11b")
			OPMODE="$NET_B_ONLY"
			;;
		"11g")
			OPMODE="$NET_G_ONLY"
			;;
		"11n")
			if [ "$SYSCFG_INDEX" = "wl0" ]; then
				OPMODE="$NET_N_ONLY_24G"
			else
				OPMODE="$NET_N_ONLY_5G"
			fi
			;;
		"11b 11g")
			OPMODE="$NET_BG_MIXED"
			;;
		"11g 11n")
			OPMODE="$NET_GN_MIXED"
			;;
		"11a 11n")
			OPMODE="$NET_AN_MIXED"
			;;
		"11b 11g 11n")
			OPMODE="$NET_BGN_MIXED"
			;;
		"11b 11g 11n 11ac")
			OPMODE="$NET_BGNAC_MIXED"
			;;
		"11a 11n 11ac")
			OPMODE="$NET_ANAC_MIXED"
			;;
		"Mixed" | "mixed" | "MIXED")
			if [ "$SYSCFG_INDEX" = "wl0" ]; then
				OPMODE="$NET_BGNAC_MIXED"
			else
				OPMODE="$NET_ANAC_MIXED"
			fi
			;;
		*)
			if [ "$SYSCFG_INDEX" = "wl0" ]; then
				OPMODE="$NET_BGNAC_MIXED"
			else
				OPMODE="$NET_ANAC_MIXED"
			fi
			;;
	esac
	
	echo "$OPMODE"
