   if [ "1" != "$SYSCFG_ula_enable" ]
   then
      return
   fi
   if [ -n "$SYSCFG_lan_ula_prefix" ]
   then
      SYSEVENT_br0_ula_prefix=${SYSCFG_lan_ula_prefix}
      sysevent set br0_ula_prefix $SYSEVENT_br0_ula_prefix
      eval `ip6calc -p $SYSEVENT_br0_ula_prefix`
      create_eui_64 $SYSCFG_lan_ifname
      eval `ip6calc -o ${PREFIX} ::${EUI_64}`
      SYSEVENT_br0_ula_ipaddress=$OR
      sysevent set br0_ula_ipaddress $SYSEVENT_br0_ula_ipaddress
      ip -6 addr add $SYSEVENT_br0_ula_ipaddress/64 scope global dev ${SYSCFG_lan_ifname}
   fi
   if [ -n "$SYSCFG_lo_ula_prefix" ]
   then
      SYSEVENT_lo_ula_prefix=${SYSCFG_lo_ula_prefix}
      sysevent set lo_ula_prefix $SYSEVENT_lo_ula_prefix
      eval `ip6calc -p $SYSEVENT_lo_ula_prefix`
      create_eui_64 lo 
      eval `ip6calc -o ${PREFIX} ::${EUI_64}`
      SYSEVENT_lo_ula_ipaddress=$OR
      sysevent set lo_ula_ipaddress $SYSEVENT_lo_ula_ipaddress
      ip -6 addr add $SYSEVENT_lo_ula_ipaddress/64 scope global dev lo
   fi
