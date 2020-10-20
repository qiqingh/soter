   unregister_dhcp_client_handlers $1
   asyncid=`sysevent get dhcp_default_router_changed_asyncid`
   if [ -n "$asyncid" ] ; then
       sysevent rm_async $asyncid
       sysevent set dhcp_default_router_changed_asyncid
   fi
   if [ -z "$1" ] ; then
      ulog wan status "$PID unregister_handlers called without parameter. Ignoring"
      return
   else
      ulog wan status "$PID unregister_handlers for wan $1"
   fi
   asyncid=`sysevent get ${1}_phylink_wan_state_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${1}_phylink_wan_state_asyncid
   fi
   asyncid=`sysevent get ${1}_desired_ipv4_link_state_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${1}_desired_ipv4_link_state_asyncid
   fi
   asyncid=`sysevent get ${1}_desired_ipv4_wan_state_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${1}_desired_ipv4_wan_state_asyncid
   fi
   asyncid=`sysevent get ${1}_current_ipv4_link_state_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${1}_current_ipv4_link_state_asyncid
   fi
