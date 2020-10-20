	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SIDEBAND=`get_sideband "$PHY_IF"`
	HTBW=`get_driver_bandwidth "$PHY_IF"`
	LEGALCY=`is_legalcy_mode $PHY_IF`
	if [ "true" = "$LEGALCY" ]; then
		HTBW=$HTBW_20MHZ
	fi
	if [ "$HTBW" = "20" ]; then
		EXT="20"
	else
		EXT=40"$SIDEBAND"
	fi
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
	if [ "Mixed" = "$SYSCFG_NETWORK_MODE" -o "mixed" = "$SYSCFG_NETWORK_MODE" -o "MIXED" = "$SYSCFG_NETWORK_MODE" ] ; then
		if [ "$SYSCFG_INDEX" = "wl0" ]; then
			SYSCFG_NETWORK_MODE="11b 11g 11n"
		else
			SYSCFG_NETWORK_MODE="11a 11n"
		fi
	fi
	if [ "$SYSCFG_INDEX" = "wl0" ]; then
		iwpriv $PHY_IF pureg 0
		iwpriv $PHY_IF puren 0
	else
		iwpriv $PHY_IF puren 0
	fi
			
			
	case "$SYSCFG_NETWORK_MODE" in
		"11a")
			OPMODE="11A"
			;;
		"11b")
			OPMODE="11B"
			;;
		"11g")
			OPMODE="11G"
			iwpriv $PHY_IF pureg 1
			;;
		"11n")
			if [ "$SYSCFG_INDEX" = "wl0" ]; then
				OPMODE=11NGHT"$EXT"
			else
				OPMODE=11NAHT"$EXT"
			fi
			iwpriv $PHY_IF puren 1
			;;
		"11b 11g")
			OPMODE="11G"
			;;
		"11a 11n")
			OPMODE=11NAHT"$EXT"
			;;
		"11b 11g 11n")
			OPMODE=11NGHT"$EXT"
			;;
		*)
			if [ "$SYSCFG_INDEX" = "wl0" ]; then
				OPMODE=11NGHT"$EXT"
			else
				OPMODE=11NAHT"$EXT"
			fi
			;;
	esac
	iwpriv $PHY_IF mode $OPMODE
	return 0
