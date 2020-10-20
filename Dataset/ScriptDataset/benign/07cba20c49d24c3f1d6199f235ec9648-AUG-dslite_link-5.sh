   STATUS=`sysevent get ${1}_desired_ipv4_link_state`
   if [ "up" != "$STATUS" ] ; then
      exit 0
   fi
   CURRENT_IPV6_ADDRESS=`sysevent get current_wan_ipv6address`
   if [ -z "$STATUS" ] ; then
      exit 0
   fi
   SYSEVENT_AFTR=`sysevent get dhcpv6_aftr`
   if [ -z "$SYSEVENT_AFTR" ] ; then
      ulog dslite_link status "$PID Detected that dhcpv6 lost its lease to the aftr"
   else
      ulog dslite_link status "$PID Detected that dhcpv6 got an aftr at $SYSEVENT_AFTR"
   fi
   NAMESPACE=$1
   STATUS=`sysevent get ${1}_current_ipv4_link_state`
   if [ "up" = "$STATUS" ] ; then
      ulog dslite_link status "$PID tearing down tunnel in order to rebuild it"
      do_stop_dslite
      WAN_STATUS=`sysevent get ${1}_current_ipv4_wan_state`
      while [ "down" != "$WAN_STATUS" ] ; do
         sleep 1
         WAN_STATUS=`sysevent get ${1}_current_ipv4_wan_state`
      done
      ulog dslite_link status "$PID bringing up tunnel again"
   fi
   INPUT_PARAM_1="${NAMESPACE}_desired_ipv4_link_state"
