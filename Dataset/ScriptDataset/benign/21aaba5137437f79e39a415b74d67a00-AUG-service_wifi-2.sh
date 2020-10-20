	ulog wlan status "${SERVICE_NAME}, service_init()"
	SYSCFG_FAILED='false'
	FOO=`utctx_cmd get device::deviceType wl_wmm_support lan_ifname lan_wl_physical_ifnames wl0_ssid wl1_ssid wl0_state wl0_guest_vap wl0_guest_enabled guest_enabled guest_lan_ifname guest_wifi_phy_ifname guest_ssid_suffix guest_ssid guest_ssid_broadcast guest_lan_ipaddr guest_lan_netmask guest_vlan_id backhaul_ifname_list extender_radio_mode wl1_guest_vap wl1_guest_enabled wl1_guest_ssid wl1_guest_ssid_broadcast`
	eval $FOO
	if [ $SYSCFG_FAILED = 'true' ] ; then
		ulog wlan status "${SERVICE_NAME}, $PID utctx failed to get some configuration data required by service-forwarding"
		DEBUG echo "[utopia] THE SYSTEM IS NOT SANE" > /dev/console
		sysevent set ${SERVICE_NAME}-status error
		sysevent set ${SERVICE_NAME}-errinfo "Unable to get crucial information from syscfg"
		return 0
	fi
