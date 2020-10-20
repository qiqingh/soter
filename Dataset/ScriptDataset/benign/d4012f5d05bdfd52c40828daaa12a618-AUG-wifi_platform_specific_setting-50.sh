	USER_VAP=$1
	WL_SYSCFG=`get_syscfg_interface_name $USER_VAP`
	USER_SSID=`syscfg get "$WL_SYSCFG"_ssid`
	WPA_AUTH=`get_wpa_auth "$WL_SYSCFG"`
	WSEC=`get_wsec "$WL_SYSCFG"`
	wl -i $USER_VAP wpa_auth 0
	wl -i $USER_VAP wsec 0
	wl -i $USER_VAP eap 0
	wl -i $USER_VAP auth 0
	wl -i $USER_VAP ssid -C $MBSS_PRIMARY "$USER_SSID" > /dev/null
	case "$WPA_AUTH" in
	"0")
		wl -i $USER_VAP wsec_restrict 0
		RET=$?
		;;
	"1")
		set_driver_wep_security ${USER_VAP}
		RET=0
		;;
	*)
		wl -i $USER_VAP wsec $WSEC
		wl -i $USER_VAP wsec_restrict 1
		wl -i $USER_VAP wpa_auth $WPA_AUTH
		wl -i $USER_VAP eap 1
		wl -i $USER_VAP auth 0
		RET=0
		;;
	esac
	syscfg_set "$WL_SYSCFG"_wpa_auth $WPA_AUTH
 	if [ -n "$WSEC" ]; then
		syscfg_set "$WL_SYSCFG"_wsec $WSEC
	fi
	MODEL_NAME=`syscfg get device::model_base`
	if [ -z "$MODEL_NAME" ] ; then
		MODEL_NAME=`syscfg get device::modelNumber`
		MODEL_NAME=${MODEL_NAME%-*}	
	fi
	if [ "EA9200" = "$MODEL_NAME" ] || [ "EA9500" = "$MODEL_NAME" ] || [ "EA9400" = "$MODEL_NAME" ] ; then
		wl -i $USER_VAP mfp_config 0
	fi
	if [ "enabled" = "`syscfg get "$WL_SYSCFG"_pmf`" ] ; then
		SYSCFG_SECURITY_MODE=`syscfg get "$WL_SYSCFG"_security_mode`
		if [ "wpa2-personal" = "$SYSCFG_SECURITY_MODE" ] || [ "wpa-mixed" = "$SYSCFG_SECURITY_MODE" ]; then	
			wl -i $USER_VAP mfp_config 1
		fi
	fi
	return $RET
