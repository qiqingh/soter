	ulog wlan status "${SERVICE_NAME}, wifi_config_changed_handler()"
	echo "${SERVICE_NAME}, wifi_config_changed_handler()"
	if [ "0" = "`syscfg_get bridge_mode`" ] && [ "started" != "`sysevent get lan-status`" ] ; then
		ulog wlan status "${SERVICE_NAME}, LAN is not started,ignore the request"
		echo "${SERVICE_NAME}, LAN is not started,ignore the request"
		return 1
	fi
	if [ -f $CHANGED_FILE ]; then
		mv $CHANGED_FILE $CHANGED_FILE".prev"
	fi
	PHY_LIST_RESTART=""
	VIR_LIST_RESTART=""
	GUEST_LIST_RESTART=""
	for PHY_IF in $PHYSICAL_IF_LIST; do
		SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
		restart_required "physical" ${SYSCFG_INDEX}
		PHY_RESTART="$?"
		if [ "$PHY_RESTART" = "1" ] ; then
			ulog wlan status "${SERVICE_NAME}, physical changes detected: $PHY_IF"
			echo "${SERVICE_NAME}, physical changes detected: $PHY_IF"
			PHY_LIST_RESTART="`echo $PHY_LIST_RESTART` $PHY_IF"
		else	
			restart_required "virtual" ${SYSCFG_INDEX}
			VIR_RESTART="$?"
			if [ "$VIR_RESTART" = "1" ] ; then
				ulog wlan status "${SERVICE_NAME}, virtual changes detected: $PHY_IF"
				echo "${SERVICE_NAME}, virtual changes detected: $PHY_IF"
				VIR_LIST_RESTART="`echo $VIR_LIST_RESTART` $PHY_IF"
			else
				restart_required "guest" ${SYSCFG_INDEX}
				GUEST_RESTART="$?"
				if [ "$GUEST_RESTART" = "1" ]; then
					ulog wlan status "${SERVICE_NAME}, guest changes detected: $PHY_IF"
					echo "${SERVICE_NAME}, guest changes detected: $PHY_IF"
					GUEST_LIST_RESTART="`echo $GUEST_LIST_RESTART` $PHY_IF"
				fi
			fi
		fi
	done
	if [ -z "$PHY_LIST_RESTART" ] && [ -z "$VIR_LIST_RESTART" ] && [ -z "$GUEST_LIST_RESTART" ]; then
		ulog wlan status "${SERVICE_NAME}, no wifi config changes detected,ignore the request"
		echo "${SERVICE_NAME}, no wifi config changes detected,ignore the request"
		return 1
	fi
	sysevent set ${SERVICE_NAME}-status starting
	for PHY_IF in $PHY_LIST_RESTART; do
		ulog wlan status "${SERVICE_NAME}, physical interface is required to restart: $PHY_IF"
		echo "${SERVICE_NAME}, physical interface is required to restart: $PHY_IF"
		wifi_virtual_stop $PHY_IF
		stop_hostapd $PHY_IF
		wifi_physical_stop $PHY_IF
		wifi_physical_start $PHY_IF
		wifi_virtual_start $PHY_IF
	done
	for PHY_IF in $VIR_LIST_RESTART; do
		SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
		VIR_IF=`syscfg_get "$SYSCFG_INDEX"_user_vap`
		if [ ! -z "$VIR_IF" ]; then
			ulog wlan status "${SERVICE_NAME}, virtual interface is required to restart: $PHY_IF"
			echo "${SERVICE_NAME}, virtual interface is required to restart: $PHY_IF"
			wifi_virtual_stop $PHY_IF
			stop_hostapd $PHY_IF
			wifi_virtual_start $PHY_IF
		fi
	done
	for PHY_IF in $GUEST_LIST_RESTART; do
		SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
		VIR_IF=`syscfg_get "$SYSCFG_INDEX"_guest_vap`
		if [ ! -z "$VIR_IF" ]; then
			ulog wlan status "${SERVICE_NAME}, guest interface is required to restart: $PHY_IF"
			echo "${SERVICE_NAME}, guest interface is required to restart: $PHY_IF"
			wifi_guest_restart $PHY_IF
		fi
	done
	if [ "" != "$PHY_LIST_RESTART" ] || [ "" != "$VIR_LIST_RESTART" ] ; then
		start_hostapd
	fi
	update_wifi_cache "physical"
	update_wifi_cache "virtual"
	update_wifi_cache "guest"
	if [ "`syscfg_get wl_wmm_support`" = "enabled" ] && [ "`syscfg_get wl0_network_mode`" = "11b" ]; then
        	VAP_IF=`syscfg_get wl0_physical_ifname`
        	iwpriv $VAP_IF setwmmparams 1 0 1 4
        	iwpriv $VAP_IF setwmmparams 1 1 1 4
        	iwpriv $VAP_IF setwmmparams 1 2 1 3
        	iwpriv $VAP_IF setwmmparams 1 3 1 2
        	iwpriv $VAP_IF setwmmparams 2 0 1 10
        	iwpriv $VAP_IF setwmmparams 2 1 1 10
        	iwpriv $VAP_IF setwmmparams 2 2 1 4
        	iwpriv $VAP_IF setwmmparams 2 3 1 3
	fi
	sysevent set ${SERVICE_NAME}-status started
	return 0
