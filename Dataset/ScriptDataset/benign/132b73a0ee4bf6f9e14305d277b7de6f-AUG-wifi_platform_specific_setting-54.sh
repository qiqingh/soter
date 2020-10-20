	ONE_TIME=`sysevent get physical-one-time-setting`
	if [ "$ONE_TIME" != "TRUE" ] ; then
		ulog wlan status "wifi, platform_physical_onetime_setting()"
		sysevent set wl0_status "down"
		sysevent set wl0_guest_status "down"
		sysevent set wl0_tc_status "down"
		sysevent set wl1_status "down"
		sysevent set wl1_guest_status "down"
		sysevent set wl1_tc_status "down"
		if [ "1" = "`syscfg get wifi::band_steering_configure`" ]; then
			sysevent set wl2_status "down"
		fi
		enable_radios
		set_driver_country_code
		set_macs
		set_channel_list
		nvram_set acs_2g_ch_no_restrict 1
		nvram_set acs_2g_ch_no_ovlp 1
		for PHY_IF in $PHYSICAL_IF_LIST; do
			bring_phy_if_down $PHY_IF
			wl -i $PHY_IF ap 1
			wl -i $PHY_IF spect 0
			wl -i $PHY_IF mpc 0
		done
		nvram_set wl_net_reauth 36000
		nvram_set wl0_net_reauth 36000
		nvram_set wl1_net_reauth 36000
		nvram_set wl2_net_reauth 36000
		sysevent set physical-one-time-setting "TRUE"
	fi
