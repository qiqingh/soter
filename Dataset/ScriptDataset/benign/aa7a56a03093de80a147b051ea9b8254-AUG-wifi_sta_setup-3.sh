	brctl addif $BRIDGE_NAME $SELECTED_STA_IF
	BF_ENABLED=false
	BW=2g
	CAP=3
	BAND=b
	if [ "5g" = "`echo $SELECTED_RADIO | tr [:upper:] [:lower:]`" ]; then
		if [ "1" = "`syscfg get wl1_txbf_enabled`" ]; then
			BF_ENABLED=true
		fi
		BW=5g
		CAP=7
		BAND=a
	fi
	ifconfig $SELECTED_STA_IF up
	wl -i $SELECTED_STA_IF down
	wl -i $SELECTED_STA_IF band $BAND
	wl -i $SELECTED_STA_IF ap 0
	wl -i $SELECTED_STA_IF apsta 0
	wl -i $SELECTED_STA_IF infra 1
	wl -i $SELECTED_STA_IF psta 1
	wl -i $SELECTED_STA_IF amsdu 0
	wl -i $SELECTED_STA_IF rx_amsdu_in_ampdu 0
	if [ "a" = "$BAND" ]; then
		wl -i $SELECTED_STA_IF vhtmode 1
	fi
	if [ "2g" = "`syscfg get wifi_sta_radio`" ] ; then
		if [ "1" = "`syscfg get wl0_256qam_enabled`" ] ; then
			wl -i $SELECTED_STA_IF vhtmode 1
			wl -i $SELECTED_STA_IF frameburst 1
			wl -i $SELECTED_STA_IF ampdu_mpdu 64
			wl -i $SELECTED_STA_IF ack_ratio 4
			wl -i $SELECTED_STA_IF vht_features 1
		else
			wl -i $SELECTED_STA_IF ampdu_mpdu -1
			wl -i $SELECTED_STA_IF ack_ratio 2
			wl -i $SELECTED_STA_IF vht_features 0
		fi
	fi
	wl -i $SELECTED_STA_IF bw_cap $BW $CAP
	wl -i $SELECTED_STA_IF nmode `get_nmode_from_ifname $SELECTED_STA_IF`
	wl -i $SELECTED_STA_IF sta_retry_time 5
	wl -i $SELECTED_STA_IF assoc_retry_max 3
	wl -i $SELECTED_STA_IF mcast_regen_bss_enable 1
	if [ "true" = "$BF_ENABLED" ]; then
		wl -i $SELECTED_STA_IF txbf_bfr_cap 1
		wl -i $SELECTED_STA_IF txbf_bfe_cap 1
	fi
	wl -i $SELECTED_STA_IF up
