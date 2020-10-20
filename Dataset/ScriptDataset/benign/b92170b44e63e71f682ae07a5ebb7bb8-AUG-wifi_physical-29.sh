	PHY_IF=$1
	WLINDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	STBC=`get_driver_stbc "$PHY_IF"`
	AC_SUPPORTED=`syscfg_get "$WLINDEX"_ac_supported`
	
	if [ -n $STBC ]; then
		if [ "1" = "$AC_SUPPORTED" ]; then
			set_wifi_val $PHY_IF HT_STBC 1
			set_wifi_val $PHY_IF VHT_STBC $STBC
            echo "${SERVICE_NAME}, HT_STBC 1"
            echo "${SERVICE_NAME}, VHT_STBC $STBC"
		else
			set_wifi_val $PHY_IF HT_STBC $STBC
			set_wifi_val $PHY_IF VHT_STBC 0
            echo "${SERVICE_NAME}, HT_STBC $STBC"
            echo "${SERVICE_NAME}, VHT_STBC 0"
		fi
	fi
	return 0
