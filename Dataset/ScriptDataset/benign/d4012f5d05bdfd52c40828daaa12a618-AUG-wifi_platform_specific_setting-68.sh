	if [ "1" != "`syscfg get wifi::band_steering_configure`" ] ; then
		return
	fi
	if [ "1" != "`syscfg get bsd_test`" ] ; then
		nvram_unset bsd_ifnames
		nvram_unset bsd_role
		nvram_unset bsd_scheme
		nvram_unset wl0_bsd_steering_policy
		nvram_unset wl1_bsd_steering_policy
		nvram_unset wl2_bsd_steering_policy
		nvram_unset wl0_bsd_sta_select_policy
		nvram_unset wl1_bsd_sta_select_policy
		nvram_unset wl2_bsd_sta_select_policy
		nvram_unset wl0_bsd_if_select_policy
		nvram_unset wl1_bsd_if_select_policy
		nvram_unset wl2_bsd_if_select_policy
		nvram_unset wl0_bsd_if_qualify_policy
		nvram_unset wl1_bsd_if_qualify_policy
		nvram_unset wl2_bsd_if_qualify_policy
		nvram_unset bsd_bounce_detect
	fi
	killall -q bsd
	
	return
