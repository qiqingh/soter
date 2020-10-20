   SYSEVENT_br0_ula_prefix=`sysevent get br0_ula_prefix`
   SYSEVENT_br0_ula_ipaddress=`sysevent get br0_ula_ipaddress`
   if [ -n "$SYSEVENT_br0_ula_prefix" ]
   then
      ip -6 addr del $SYSEVENT_br0_ula_ipaddress/64 scope global dev ${SYSCFG_lan_ifname}
   fi
   SYSEVENT_lo_ula_prefix=`sysevent get lo_ula_prefix`
   SYSEVENT_lo_ula_ipaddress=`sysevent get lo_ula_ipaddress`
   if [ -n "$SYSEVENT_lo_ula_prefix" ]
   then
      ip -6 addr del ${SYSEVENT_lo_ula_ipaddress}/64 scope global dev lo
   fi
  sysevent set br0_ula_prefix
  sysevent set br0_ula_ipaddress
  sysevent set lo_ula_prefix
  sysevent set lo_ula_ipaddress
