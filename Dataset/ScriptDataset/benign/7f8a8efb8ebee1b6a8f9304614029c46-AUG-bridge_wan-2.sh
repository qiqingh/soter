   service_init
   sysevent set ipv6_connection_state "ipv6 bridge connection going down"
   sysevent set ipv6-errinfo
   sysevent set ipv6-status stopping
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_lan_ifname/accept_ra
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_lan_ifname/accept_ra_defrtr
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_lan_ifname/accept_ra_pinfo
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_lan_ifname/autoconf
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_guest_lan_ifname/accept_ra
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_guest_lan_ifname/accept_ra_defrtr
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_guest_lan_ifname/accept_ra_pinfo
   echo 0 > /proc/sys/net/ipv6/conf/$SYSCFG_guest_lan_ifname/autoconf
   sysevent set current_ipv6_wan_state down
   sysevent set ipv6-status stopped
   sysevent set ipv6_firewall-restart
   sysevent set ipv6_connection_state "ipv6 bridge connection down"
