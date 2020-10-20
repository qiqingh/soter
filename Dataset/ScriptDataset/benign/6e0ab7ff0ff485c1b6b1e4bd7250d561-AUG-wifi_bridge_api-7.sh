	STA_VIR_IF=`syscfg_get wifi_sta_vir_if`
    STAT_FILE=/tmp/iwpriv_stat_$STA_VIR_IF
	if [ -z "$STA_VIR_IF" ]; then
		echo "error: unknown channel width"
		exit
	fi
    iwpriv $STA_VIR_IF stat > $STAT_FILE
	cat $STAT_FILE | grep "BW80" > /dev/null
    bw80=$?
	cat $STAT_FILE | grep "BW40" > /dev/null
    bw40=$?
	cat $STAT_FILE | grep "BW20" > /dev/null
    bw20=$?
    if [ "$bw80" = "0" -o "$bw40" = "0" ]; then
		echo "wide"
    elif [ "$bw20" = "0" ]; then
		echo "standard"
    else
		echo "error: unknown channel width"
    fi
