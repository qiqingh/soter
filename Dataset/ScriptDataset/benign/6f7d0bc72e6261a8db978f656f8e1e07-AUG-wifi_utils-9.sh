	SECURITY_MODE=""
	INDEX=0
	if [ "Extender" = "$DEVICE_TYPE" ]; then
		if [ ! -z "$EXTENDER_RADIO_MODE" ] && [ $EXTENDER_RADIO_MODE = "1" ]; then
			INDEX=1
		else
			INDEX=0
		fi
		MODE_STRING=`syscfg_get wl"$INDEX"_security_mode`
	else
		MODE_STRING=`syscfg_get $1`
	fi
	if [ "wpa-personal" = "$MODE_STRING" ]; then
		SECURITY_MODE=1	
	elif [ "wpa2-personal" = "$MODE_STRING" ]; then
		SECURITY_MODE=2	
	elif [ "wpa-mixed" = "$MODE_STRING" ]; then
		SECURITY_MODE=3	
	elif [ "wpa-enterprise" = "$MODE_STRING" ]; then
		SECURITY_MODE=4	
	elif [ "wpa2-enterprise" = "$MODE_STRING" ]; then
		SECURITY_MODE=5	
	elif [ "wpa-enterprise-mixed" = "$MODE_STRING" ]; then
		SECURITY_MODE=6	
	elif [ "radius" = "$MODE_STRING" ]; then
		SECURITY_MODE=7	
	elif [ "wep" = "$MODE_STRING" ]; then
		SECURITY_MODE=8	
	elif [ "wep-auto" = "$MODE_STRING" ]; then
		SECURITY_MODE=8	
	elif [ "wep-open" = "$MODE_STRING" ]; then
		SECURITY_MODE=8	
	elif [ "wep-shared" = "$MODE_STRING" ]; then
		SECURITY_MODE=8	
	elif [ "disabled" = "$MODE_STRING" ]; then
		SECURITY_MODE=0	
	else 
		SECURITY_MODE=0	
	fi
	echo "$SECURITY_MODE"	
