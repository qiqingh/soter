	echo "${SERVICE_NAME}, restart wscd"
        killall -9 wscd
		killall -9 miniupnpd
		rm /var/run/miniupnpd*
	killall -9 wsc_monitor
	rm /var/run/wsc_monitor.pid*
		if [ "`syscfg_get wl0_state`" != "down" ]; then
			start_wscd "ra0"
		fi
		if [ "`syscfg_get wl1_state`" != "down" ]; then
			if [ "`syscfg_get wl0_state`" != "down" ]; then
				sleep 30
			fi
			start_wscd "rai0"
		fi
