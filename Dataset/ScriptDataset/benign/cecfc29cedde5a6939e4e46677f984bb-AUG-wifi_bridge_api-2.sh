	STA_VIR_IF=`syscfg_get wifi_sta_vir_if`
	if [ -z "$STA_VIR_IF" ]; then
		echo "error: no STA interface specified"
		exit
	fi
	RESULT=`iwpriv $STA_VIR_IF getlinkstatus | awk -F':' '{print $2}' | awk '{print $1}'`
	if [ "1" = "$RESULT" ]; then
		echo "yes"
	else
		echo "no"
	fi
	exit
