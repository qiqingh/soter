   ulog ipv6 passthrough "passthrough_wan.sh: bring wan down"
   echo "passthrough_wan.sh: bring wan down" >> $LOG
   sysevent set ipv6_connection_state "ipv6 passthough going down"
   sysevent set ipv6-errinfo
   sysevent set ipv6-status stopping
   echo "passthrough_wan.sh: ipv6 passthrough going down" >> $LOG
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_lan_ifname/accept_ra
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_lan_ifname/accept_ra_defrtr
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_lan_ifname/accept_ra_pinfo
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_lan_ifname/autoconf
   echo "passthrough_wan.sh: bring_wan_down: ipv6_passthrough posting events" >> $LOG
   sysevent set current_ipv6_wan_state down
   sysevent set ipv6-status stopped
   sysevent set ipv6_firewall-restart
   if [ "1" != "`syscfg get ipv6::passthrough_done_in_hw`" ] ; then
       ulog ipv6 passthrough "unloading ipv6_passthrough.ko"
       echo "passthrough_wan.sh: unloading ipv6_passthrough.ko" >> $LOG
        
       modprobe -r ipv6_passthrough.ko
       WAN=`syscfg get wan_1 ifname`
       LAN=`syscfg get lan_ifname`
       ulog ipv6 passthrough "turning off promiscuous mode for $WAN and $LAN"
       echo "passthrough_wan.sh: turning off promiscuous mode for $WAN and $LAN" >> $LOG
       ifconfig $LAN -promisc
       ifconfig $WAN -promisc
   fi
   sysevent set ipv6_connection_state "ipv6 passthrough down"
   ulog ipv6 passthrough "force clients to renew DHCP lease"
   reset_ethernet_ports
   sysevent set wifi_renew_clients
   echo "passthrough_wan.sh: bring_wan_down done" >> $LOG
