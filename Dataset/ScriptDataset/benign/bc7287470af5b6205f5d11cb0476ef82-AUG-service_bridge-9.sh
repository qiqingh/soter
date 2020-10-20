   unregister_dhcp_client_handlers
   if [ "0" != "`syscfg get bridge_mode`" ] && [ -f /etc/init.d/service_wifi/service_wifi_sta.sh ] ; then
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
   brctl delif $SYSCFG_lan_ifname $SYSCFG_wan_physical_ifname
   ip link set $SYSCFG_lan_ifname down
   if [ "`syscfg get gmac3_enable`" = "1" ] ; then
      ip link set fwd0 down
      ip link set fwd1 down
   fi
   sysevent set ${SERVICE_NAME}-errinfo
   sysevent set ${SERVICE_NAME}-status down
