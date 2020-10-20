   ASYNC=`sysevent get $DSLITE_WAITING_FOR_IPv6_WANADDR_ASYNC`
   if [ -z "$ASYNC" ] ; then
      ASYNC=`sysevent async current_wan_ipv6address /etc/init.d/service_wan/dslite_link.sh $NAMESPACE`
      sysevent set $DSLITE_WAITING_FOR_IPv6_WANADDR_ASYNC "$ASYNC"
   fi
   ASYNC=`sysevent get $DSLITE_WAITING_FOR_DHCP6_AFTR_ASYNC`
   if [ -z "$ASYNC" ] ; then
      ASYNC=`sysevent async dhcpv6_aftr /etc/init.d/service_wan/dslite_link.sh $NAMESPACE`
      sysevent set $DSLITE_WAITING_FOR_DHCP6_AFTR_ASYNC "$ASYNC"
   fi
   if [ -z "`sysevent get current_wan_ipv6address`" ] ; then
      ulog dslite_link status "$PID Deferring dslite until ipv6 address is configured on default ipv6 wan interface"
      return 0
   fi
   SYSCFG_dslite_aftr=`syscfg get dslite_aftr`
   SYSEVENT_dhcpv6_aftr=`sysevent get dhcpv6_aftr`
   if [ -z "$SYSEVENT_dhcpv6_aftr" -a -z "$SYSCFG_dslite_aftr" ] ; then
      ulog dslite_link status "$PID Deferring dslite until aftr is provisioned"
      return 0
   else
      if [ -z "$SYSEVENT_dhcpv6_aftr" ] ; then
         AFTR_STR="Using $SYSCFG_dslite_aftr provisioned in nvram"
      else
         AFTR_STR="Using $SYSEVENT_dhcpv6_aftr learned from dhcpv6"
      fi
      ulog dslite_link status "$PID $AFTR_STR"
   fi
   sysevent set ipv4_connection_state "ipv4 link going up"
   sysevent set ${NAMESPACE}_current_ipv4_link_state up
