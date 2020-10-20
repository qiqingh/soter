   sysevent set ipv4_connection_state "ipv4 link going down"
   ASYNC=`sysevent get $DSLITE_WAITING_FOR_IPv6_WANADDR_ASYNC`
   if [ -n "$ASYNC" ] ; then
      sysevent rm_async $ASYNC
      sysevent set $DSLITE_WAITING_FOR_IPv6_WANADDR_ASYNC 
   fi
   ASYNC=`sysevent get $DSLITE_WAITING_FOR_DHCP6_AFTR_ASYNC`
   if [ -n "$ASYNC" ] ; then
      sysevent rm_async $ASYNC
      sysevent set $DSLITE_WAITING_FOR_DHCP6_AFTR_ASYNC 
   fi
   sysevent set ${NAMESPACE}_current_ipv4_link_state down
