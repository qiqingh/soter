	if [ "1" != "`syscfg get wifi::band_steering_configure`" ] ; then
		return
	fi
	if [ "1" != "`syscfg get wifi::band_steering_enable`" ] ; then
		return
	fi
	USER_SSID=`syscfg get wl2_ssid`
	if [ -z "$USER_SSID" ]; then 
		DEBUG wlan status "5G User VAP ssid is empty, do NOT start band steering"
		return
	fi
	if [ "down" = "`syscfg get wl2_state`" ]; then
		ulog wlan status "5G radio down, do NOT start band steering"
		return
	fi
	if [ "1" != "`syscfg get bsd_test`" ] ; then
		if [ "2" = "`syscfg get wifi::band_steering_mode`" ] && [ "down" != "`syscfg get wl0_state`" ] && [ "down" != "`syscfg get wl1_state`" ] && [ "down" != "`syscfg get wl2_state`" ] && [ "`syscfg get wl1_ssid`" = "`syscfg get wl0_ssid`" ] && [ "`syscfg get wl1_ssid`" = "`syscfg get wl2_ssid`" ]; then
			nvram_set bsd_ifnames "eth1 eth2 eth3"
			nvram_set wl0_bsd_steering_policy "80 5 3 0 300 0x40"
			nvram_set wl1_bsd_steering_policy "0 5 3 0 0 0x10"
			nvram_set wl2_bsd_steering_policy "0 5 3 0 300 0x60"
			nvram_set wl0_bsd_sta_select_policy "4 0 300 0 0 1 0 0 0 0x40"
			nvram_set wl1_bsd_sta_select_policy "4 0 0 0 0 1 0 0 0 0x0"
			nvram_set wl2_bsd_sta_select_policy "4 0 300 0 0 -1 0 0 0 0x60"
			nvram_set wl0_bsd_if_select_policy "eth3 eth2"
			nvram_set wl1_bsd_if_select_policy "eth3 eth1"
			nvram_set wl2_bsd_if_select_policy "eth1 eth2"
			nvram_set wl0_bsd_if_qualify_policy "60 0x0 -75"
			nvram_set wl1_bsd_if_qualify_policy "0 0x0 -75"
			nvram_set wl2_bsd_if_qualify_policy "0 0x0 -75"
			nvram_set bsd_bounce_detect "180 5 1800"
			nvram_set bsd_role 3
			nvram_set bsd_scheme 2
			ulog wlan status "start band steering 3RFs"
		elif [ "1" = "`syscfg get wifi::band_steering_mode`" ] && [ "down" != "`syscfg get wl1_state`" ] && [ "down" != "`syscfg get wl2_state`" ] && [ "`syscfg get wl1_ssid`" = "`syscfg get wl2_ssid`" ]; then
			nvram_set bsd_ifnames "eth1 eth3"
			nvram_set wl0_bsd_steering_policy "80 5 3 0 300 0x00"
			nvram_set wl2_bsd_steering_policy "0 5 3 0 300 0x20"
			nvram_set wl0_bsd_sta_select_policy "4 0 300 0 0 1 0 0 0 0x0"
			nvram_set wl2_bsd_sta_select_policy "4 0 300 0 0 -1 0 0 0 0x20"
			nvram_set wl0_bsd_if_select_policy eth3
			nvram_set wl2_bsd_if_select_policy eth1
			nvram_set wl0_bsd_if_qualify_policy "60 0x0 -75"
			nvram_set wl2_bsd_if_qualify_policy "0 0x0 -75"
			nvram_set bsd_bounce_detect "180 5 1800"
			nvram_set bsd_role 3
			nvram_set bsd_scheme 2
			ulog wlan status "start band steering 2RFs"
		fi
	fi
	/usr/sbin/bsd &
	return
