	USER_VAP=$1
	WL_SYSCFG=`get_syscfg_interface_name $USER_VAP`
	SSID_BROADCAST=`get_ssid_broadcast $WL_SYSCFG`
	if [ "1" = $SSID_BROADCAST ]; then
		wl -i $USER_VAP closed 0
	else
		wl -i $USER_VAP closed 1
	fi
	SEC_ENABLED="false"
	SEC_MODE=`syscfg get $WL_SYSCFG"_security_mode"`
	if [ "wpa-personal" = "$SEC_MODE" ] || [ "wpa2-personal" = "$SEC_MODE" ] || [ "wpa-mixed" = "$SEC_MODE" ]; then
		SEC_ENABLED="true"
	fi
	if [ "true" = "$SEC_ENABLED" ]; then
		REKEY_TIME=`syscfg get $WL_SYSCFG"_key_renewal"`
	fi
	AP_ISOLATION=`syscfg get $WL_SYSCFG"_ap_isolation"`
	if [ "enabled" = "$AP_ISOLATION" ]; then
		INTRABSS=1
	else
		INTRABSS=0
	fi
	MODEL_NAME=`syscfg get device::model_base`
	if [ -z "$MODEL_NAME" ] ; then
		MODEL_NAME=`syscfg get device::modelNumber`
		MODEL_NAME=${MODEL_NAME%-*}	
	fi
	if [ "EA9200" = "$MODEL_NAME" ] || [ "EA9500" = "$MODEL_NAME" ] || [ "EA9400" = "$MODEL_NAME" ] ; then
		if [ "enabled" = "$AP_ISOLATION" ]; then
			INTRABSS=0
			dhd -i $USER_VAP ap_isolate 1
		else
			INTRABSS=1
			dhd -i $USER_VAP ap_isolate 0
		fi
	fi
	wl -i $USER_VAP ap_isolate $INTRABSS
	FRAME_BURST=`syscfg get $WL_SYSCFG"_frame_burst"`
	if [ "enabled" = "$FRAME_BURST" ]; then
		OPTLEVEL=1
	else
		OPTLEVEL=0
	fi
	REGION="`syscfg_get device::cert_region`"
	if [ "EU" = "$REGION" ]; then
		if [ "eth1" = "$USER_VAP" ] || [ "eth3" = "$USER_VAP" ]; then
			echo "wifi, setting RED CE requirements"
			OPTLEVEL=0
		fi
	fi
	wl -i $USER_VAP frameburst $OPTLEVEL
	return
