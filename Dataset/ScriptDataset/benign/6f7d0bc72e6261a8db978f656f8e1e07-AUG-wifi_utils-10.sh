	ENCRYPTION_MODE=""
	wl_index=""
	if [ "Extender" = "$DEVICE_TYPE" ]; then
		if [ ! -z "$EXTENDER_RADIO_MODE" ] && [ $EXTENDER_RADIO_MODE = "1" ]; then
			wl_index=1
		else
			wl_index=0
		fi
		ENCRYPTION_STRING=`syscfg_get wl"$INDEX"_encryption`
	else
		wl_index=`echo $1 | cut -c3`
		ENCRYPTION_STRING=`syscfg_get $1`
	fi
	SEC_MODE=`syscfg_get wl"$wl_index"_security_mode`
	if [ "wep" = "$SEC_MODE" ] || [ "wep-auto" = "$SEC_MODE" ] || [ "wep-open" = "$SEC_MODE" ] || [ "wep-shared" = "$SEC_MODE" ]; then
		TX_KEY=`syscfg_get wl"$wl_index"_tx_key`
		INDEX_KEY=`expr $TX_KEY - 1`
		CURRENT_KEY=`syscfg_get wl"$wl_index"_key_"$INDEX_KEY"`
		CURRENT_KL=`echo $CURRENT_KEY | wc -c`
		if [ 11 = `expr $CURRENT_KL` ] || [ 6 = `expr $CURRENT_KL` ]; then
			ENCRYPTION_MODE="64-bits"
		elif [ 27 = `expr $CURRENT_KL` ] || [ 14 = `expr $CURRENT_KL` ]; then
			ENCRYPTION_MODE="128-bits"
		fi
	else
		case "$ENCRYPTION_STRING" in
		"aes")
			ENCRYPTION_MODE="CCMP"
			;;
		"tkip")
			ENCRYPTION_MODE="TKIP"
			;;
		"tkip+aes")
			ENCRYPTION_MODE="TKIP CCMP"
			;;
		esac
	fi
	echo "$ENCRYPTION_MODE"	
