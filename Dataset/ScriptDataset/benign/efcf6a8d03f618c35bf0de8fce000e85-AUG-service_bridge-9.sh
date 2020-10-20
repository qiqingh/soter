   unregister_dhcp_client_handlers
   if [ "0" != "`syscfg get bridge_mode`" ] && [ -f /etc/init.d/service_wifi/wifi_sta_setup.sh ] ; then
      /etc/init.d/service_wifi/service_wifi_sta.sh wifi_sta-stop
   fi
   teardown_wireless_interfaces
   teardown_ethernet_interfaces
   ip link set $SYSCFG_lan_ifname down
   ip addr flush dev $SYSCFG_lan_ifname
   for loop in $LAN_IFNAMES
   do
      ip link set $loop down
      brctl delif $SYSCFG_lan_ifname $loop
   done
   ip link set $SYSCFG_wan_physical_ifname down
   ip link set $SYSCFG_lan_ifname down
   sysevent set ${SERVICE_NAME}-errinfo
   sysevent set ${SERVICE_NAME}-status down
