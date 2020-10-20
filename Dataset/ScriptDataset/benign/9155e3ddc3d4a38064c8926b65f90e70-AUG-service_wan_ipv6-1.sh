   asyncid=`sysevent get ${SERVICE_NAME}_phylink_wan_state_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_phylink_wan_state_asyncid
   fi
   asyncid=`sysevent get ${SERVICE_NAME}_wan-status_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_wan-status_asyncid
   fi
   asyncid=`sysevent get ${SERVICE_NAME}_desired_ipv6_link_state_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_desired_ipv6_link_state_asyncid
   fi
   asyncid=`sysevent get ${SERVICE_NAME}_lan-status_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_lan-status_asyncid
   fi
   asyncid=`sysevent get ${SERVICE_NAME}_guest_lan-status_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_guest_lan-status_asyncid
   fi
   asyncid=`sysevent get ${SERVICE_NAME}_desired_ipv6_wan_state_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_desired_ipv6_wan_state_asyncid
   fi
   asyncid=`sysevent get ${SERVICE_NAME}_current_ipv6_link_state_asyncid`
   if [ -n "$asyncid" ] ; then
      sysevent rm_async $asyncid
      sysevent set ${SERVICE_NAME}_current_ipv6_link_state_asyncid
   fi