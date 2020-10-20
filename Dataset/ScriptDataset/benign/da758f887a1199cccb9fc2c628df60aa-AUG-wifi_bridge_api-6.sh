	STA_VIR_IF=`syscfg_get wifi_sta_vir_if`
    STAT_FILE=/tmp/iwpriv_stat_$STA_VIR_IF
	if [ -z "$STA_VIR_IF" ]; then
		echo "error: unknown network mode"
		exit
	fi
    iwpriv $STA_VIR_IF stat > $STAT_FILE
	cat $STAT_FILE | grep "NSS" > /dev/null
    mode_ac=$?
	cat $STAT_FILE | grep "MCS" > /dev/null
    mode_n=$?
	cat $STAT_FILE | grep "LP," > /dev/null
    mode_ab_lp=$?
	cat $STAT_FILE | grep "SP," > /dev/null
    mode_ab_sp=$?
    if [ "$mode_ac" = "0" ]; then
        echo "11ac"
    elif [ "$mode_n" = "0" ]; then
        echo "11n"
    elif [ "$mode_ab_lp" != "0" -a "$mode_ab_sp" != "0" ]; then
        echo "11g"
    elif [ "$STA_VIR_IF" = "apcli0" ]; then
        echo "11b"
    else
        echo "11a"
    fi
