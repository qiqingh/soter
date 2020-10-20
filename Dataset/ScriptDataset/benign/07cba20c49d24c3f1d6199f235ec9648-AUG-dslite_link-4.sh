   STATUS=`sysevent get ${1}_desired_ipv4_link_state`
   if [ "up" != "$STATUS" ] ; then
      exit 0
   fi
   CURRENT_IPV6_ADDRESS=`sysevent get current_wan_ipv6address`
   if [ -z "$STATUS" ] ; then
      exit 0
   fi
   ulog dslite_link status "$PID Detected change to ipv6 default wan address to $CURRENT_IPV6_ADDRESS"
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
      ulog dslite_link status "$PID bringing up tunnel using new local address"
   fi
   INPUT_PARAM_1="${NAMESPACE}_desired_ipv4_link_state"
