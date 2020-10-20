	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_TRANS_RATE=`syscfg_get "$SYSCFG_INDEX"_transmission_rate`
	if [ -n "$SYSCFG_TRANS_RATE" ] && [ "auto" = "$SYSCFG_TRANS_RATE" ]; then
		TRANS_RATE=0
	else
		case "$SYSCFG_TRANS_RATE" in
			"6000000")
				TRANS_RATE=12
				;;
			"9000000")
				TRANS_RATE=18
				;;
			"12000000")
				TRANS_RATE=24
				;;
			"18000000")
				TRANS_RATE=36
				;;
			"24000000")
				TRANS_RATE=48
				;;
			"36000000")
				TRANS_RATE=72
				;;
			"48000000")
				TRANS_RATE=96
				;;
			"54000000")
				TRANS_RATE=108
				;;
			*)
				TRANS_RATE=0
				ulog wlan status "invalid transmission_rate: $1"
				;;
		esac
	fi
			
	echo "$TRANS_RATE"
