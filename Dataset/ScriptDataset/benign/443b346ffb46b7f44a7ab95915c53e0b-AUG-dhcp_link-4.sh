   if [ ! -f "$UDHCPC_PID_FILE" ] ; then
      ulog dhcp_link status "starting dhcp client on bridge ($WAN_IFNAME)"
      service_init
      udhcpc -S -b -i $SYSCFG_lan_ifname -h $SYSCFG_hostname -p $UDHCPC_PID_FILE --arping -s $UDHCPC_SCRIPT $DHCPC_EXTRA_PARAMS
   elif [ "`cat $UDHCPC_PID_FILE`" != "`pidof udhcpc`" ] ; then
      ulog dhcp_link status "dhcp client `cat $UDHCPC_PID_FILE` died"
      do_stop_dhcp
      ulog dhcp_link status "starting dhcp client on bridge ($SYSCFG_lan_ifname)"
      udhcpc -S -b -i $SYSCFG_lan_ifname -h $SYSCFG_hostname -p $UDHCPC_PID_FILE --arping -s $UDHCPC_SCRIPT $DHCPC_EXTRA_PARAMS
   else
      ulog dhcp_link status "dhcp client is already active on bridge ($SYSCFG_lan_ifname) as `cat $UDHCPC_PID_FILE`"
   fi
    sysevent set current_ipv4_wan_state up
