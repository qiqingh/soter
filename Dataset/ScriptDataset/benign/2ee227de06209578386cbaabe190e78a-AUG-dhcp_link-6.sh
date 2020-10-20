   if [ "1" != "`syscfg get bridge_mode`" ] ; then
      ulog dhcp_link status "Requesting dhcp renew on ($WAN_IFNAME), but not provisioned for dhcp."
      return 0
   fi
   ulog dhcp_link status "renewing dhcp lease on bridge"
    if [ -f "$UDHCPC_PID_FILE" ] ; then
        kill -SIGUSR1 `cat $UDHCPC_PID_FILE`
    else
       ulog dhcp_link status "restarting dhcp client on bridge"
       udhcpc -S -b -i $SYSCFG_lan_ifname -h $SYSCFG_hostname -p $UDHCPC_PID_FILE --arping -s $UDHCPC_SCRIPT $DHCPC_EXTRA_PARAMS
   fi
