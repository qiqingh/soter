   SYSCFG_FAILED='false'
   FOO=`utctx_cmd get lan_ifname guest_enabled guest_lan_ifname guest_wifi_phy_ifname wl0_guest_vap guest_ssid_suffix guest_ssid guest_ssid_broadcast guest_lan_ipaddr guest_lan_netmask wl0_ssid wl0_state wl1_ssid guest_vlan_id backhaul_ifname_list extender_radio_mode`
   eval "$FOO"
   if [ $SYSCFG_FAILED = 'true' ] ; then
     ulog guest_lan status "$PID utctx failed to get some configuration data"
     ulog guest_lan status "$PID GUEST LAN CANNOT BE CONTROLLED"
     exit
   fi
