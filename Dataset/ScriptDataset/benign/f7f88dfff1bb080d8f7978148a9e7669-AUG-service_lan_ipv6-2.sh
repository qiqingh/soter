  
 sysevent set ipv6_delegated_prefix
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
   sysevent set radvd-reload
