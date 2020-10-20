   ulog dhcp_link status "releasing dhcp lease on bridge"
   service_init
   if [ -f "$UDHCPC_PID_FILE" ] ; then
      kill -SIGUSR2 `cat $UDHCPC_PID_FILE`
   fi
   ip -4 addr flush dev $SYSCFG_lan_ifname
