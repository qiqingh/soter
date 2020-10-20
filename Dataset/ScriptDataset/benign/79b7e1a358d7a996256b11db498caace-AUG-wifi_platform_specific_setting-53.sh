	CHECK_STATUS=`sysevent get wifi_system_boot_init`
	if [ "1" != "$CHECK_STATUS" ]; then
		echo "wifi, system_boot_init"
		. $WIFI_SYSTEM_BOOT_INIT_SCRIPT
	fi
	ONE_TIME=`sysevent get physical-one-time-setting`
	if [ "$ONE_TIME" != "TRUE" ] ; then
		ulog wlan status "wifi, platform_physical_onetime_setting()"
		sysevent set wl0_status "down"
		sysevent set wl0_guest_status "down"
		sysevent set wl0_tc_status "down"
		sysevent set wl1_status "down"
		sysevent set wl1_guest_status "down"
		sysevent set wl1_tc_status "down"
		enable_radios
		set_driver_country_code
		set_macs
		set_channel_list
		nvram_set acs_2g_ch_no_restrict 1
		nvram_set acs_2g_ch_no_ovlp 1
		nvram_set wps_random_ssid_prefix "Linksys_WPS_"
		for PHY_IF in $PHYSICAL_IF_LIST; do
			bring_phy_if_down $PHY_IF
			wl -i $PHY_IF ap 1
			wl -i $PHY_IF spect 0
			wl -i $PHY_IF mpc 0
		done
		sysevent set physical-one-time-setting "TRUE"
	fi
