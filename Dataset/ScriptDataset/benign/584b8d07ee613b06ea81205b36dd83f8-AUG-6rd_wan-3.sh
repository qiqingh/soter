   service_init
   SYSEVENT_current_wan_ipv6_ifname=`sysevent get current_wan_ipv6_ifname`
   sysevent set ipv6_connection_state "6rd connection going down"
   sysevent set ipv6-errinfo
   sysevent set ipv6-status stopping
   ip -6 route del default via ::$SIXRD_RELAY dev ${SYSEVENT_current_wan_ipv6_ifname} >> $LOG 2>&1
   ip -6 route flush dev ${SYSEVENT_current_wan_ipv6_ifname} >> $LOG 2>&1
   ip link set dev ${SYSEVENT_current_wan_ipv6_ifname} down >> $LOG 2>&1
   ip tunnel del ${SYSEVENT_current_wan_ipv6_ifname} >> $LOG 2>&1
   if [ -n "${SYSEVENT_current_lo_ipv6address}" ] 
   then
      ip -6 addr del ${SYSEVENT_current_lo_ipv6address}/64 dev lo >> $LOG 2>&1
      sysevent set current_lo_ipv6address
      SYSEVENT_current_lo_ipv6address=
   fi
   if [ -n "${SYSEVENT_current_guest_lan_ipv6address}" ] 
   then
      ip -6 addr del ${SYSEVENT_current_guest_lan_ipv6address}/64 dev $SYSCFG_guest_lan_ifname >> $LOG 2>&1
      sysevent set ${SYSCFG_guest_lan_ifname}_ipv6_prefix_lifetime_default
      save_lan_ipv6_prefix $SYSCFG_guest_lan_ifname 
      sysevent set current_guest_lan_ipv6address
      SYSEVENT_current_guest_lan_ipv6address=
   fi
   if [ -n "${SYSEVENT_current_lan_ipv6address}" ]
   then
      ip -6 addr del ${SYSEVENT_current_lan_ipv6address}/64 dev $SYSCFG_lan_ifname >> $LOG 2>&1
      sysevent set ${SYSCFG_lan_ifname}_ipv6_prefix_lifetime_default
      save_lan_ipv6_prefix $SYSCFG_lan_ifname 
      sysevent set current_lan_ipv6address
      SYSEVENT_current_lan_ipv6address=
   fi
   sysevent set ipv6_wan-stopped
   sysevent set ipv6_delegated_prefix
   if [ "6rd" = "`sysevent get current_wan_ipv6address_owner`" ] ; then
      sysevent set current_wan_ipv6address
   fi
   sysevent set current_ipv6_wan_state down
   sysevent set ipv6-status stopped
   sysevent set ipv6_firewall-restart
   sysevent set sixrd_state
   sysevent set radvd-reload
   sysevent set 6rd_tunnel_status
   sysevent set ipv6_connection_state "6rd connection down"
