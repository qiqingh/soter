	ulog wlan status "${SERVICE_NAME}, service_init()"
	SYSCFG_FAILED='false'
	FOO=`utctx_cmd get device::deviceType wl_wmm_support lan_wl_physical_ifnames wl0_ssid wl1_ssid lan_ifname guest_enabled guest_lan_ifname guest_wifi_phy_ifname wl0_guest_vap guest_ssid_suffix guest_ssid guest_ssid_broadcast guest_lan_ipaddr guest_lan_netmask wl0_state guest_vlan_id backhaul_ifname_list extender_radio_mode`
	eval $FOO
	if [ $SYSCFG_FAILED = 'true' ] ; then
		ulog wlan status "$PID utctx failed to get some configuration data required by service-forwarding"
		ulog wlan status "$PID THE SYSTEM IS NOT SANE"
		echo "${SERVICE_NAME}, [utopia] utctx failed to get some configuration data required by service-system" > /dev/console
		echo "${SERVICE_NAME}, [utopia] THE SYSTEM IS NOT SANE" > /dev/console
		sysevent set ${SERVICE_NAME}-status error
		sysevent set ${SERVICE_NAME}-errinfo "Unable to get crucial information from syscfg"
		exit
	fi
	RECONFIGURE="false"
	return 0
