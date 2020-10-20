	STA_VIR_IF=`syscfg_get wifi_sta_vir_if`
    PROC_APCLI_STAT=""
	if [ -z "$STA_VIR_IF" ]; then
		echo "error: no STA interface specified"
		exit
	fi
	PROC_APCLI_STAT="/tmp/apcliconnstatus"
    iwpriv $STA_VIR_IF get connStatus
    cat $PROC_APCLI_STAT
