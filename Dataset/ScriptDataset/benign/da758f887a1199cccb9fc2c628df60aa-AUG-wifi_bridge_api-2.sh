	STA_VIR_IF=`syscfg_get wifi_sta_vir_if`
    PROC_APCLI_STAT=""
	if [ -z "$STA_VIR_IF" ]; then
		echo "error: no STA interface specified"
		exit
	fi
	PROC_APCLI_STAT="/tmp/apcliconnstatus"
    iwconfig $STA_VIR_IF | grep "Not-Associated" > /dev/null
    ret_not_assoc=$?
    iwpriv $STA_VIR_IF get connStatus
    conn_stat=`cat $PROC_APCLI_STAT`
    if [ "$ret_not_assoc" != "0" -a "$conn_stat" != "0" ]; then
        echo "yes"
    else
        echo "no"
    fi
	exit
