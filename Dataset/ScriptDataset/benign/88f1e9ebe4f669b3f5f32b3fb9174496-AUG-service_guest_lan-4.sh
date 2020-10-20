    V_IF=$RADIO_24G_IF
    get_syscfg_interface_index $V_IF
    WL_INDEX=$?
   if [ ! -z $SYSCFG_wl0_guest_vap ]; then
	brcm_start_guest_ap $RADIO_24G_IF 
	GUEST_SSID=`syscfg get guest_ssid`
	if [ "0" = $SYSCFG_guest_ssid_broadcast ] ; then
            HIDE_SSID=1
	else
            HIDE_SSID=0 
	fi
	GUEST_VAP=`syscfg get wl"$WL_INDEX"_guest_vap`
	wl -i $GUEST_VAP ssid "$GUEST_SSID" > /dev/null   # remove echoing from wl
	wl -i $GUEST_VAP closed $HIDE_SSID
	wl -i $RADIO_24G_IF bss -C 1 up
	ifconfig $GUEST_VAP up
    fi
