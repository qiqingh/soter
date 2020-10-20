	STA_VIR_IF=`syscfg_get wifi_sta_vir_if`
	if [ -z "$STA_VIR_IF" ]; then
		echo "error: no STA interface specified"
		exit
	fi
	iwpriv $STA_VIR_IF getrssi | awk -F':' '{print $2}'
