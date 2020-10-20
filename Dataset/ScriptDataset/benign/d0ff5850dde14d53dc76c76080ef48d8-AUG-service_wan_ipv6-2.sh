   sysevent setoptions desired_ipv6_link_state $TUPLE_FLAG_EVENT
   sysevent setoptions desired_ipv6_wan_state $TUPLE_FLAG_EVENT
   case "$IPV6_WAN_PROTO" in
      normal)
         ulog ipv6 status "$PID installing handlers for default_ipv6_link and default_ipv6_wan"
         asyncid=`sysevent async phylink_wan_state /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_phylink_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async wan-status /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_wan-status_asyncid "$asyncid"
         asyncid=`sysevent async desired_ipv6_link_state /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_desired_ipv6_link_state_asyncid "$asyncid"
         asyncid=`sysevent async lan-status /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_lan-status_asyncid "$asyncid"
         asyncid=`sysevent async guest_access-status /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_guest_access-status_asyncid "$asyncid"
         asyncid=`sysevent async desired_ipv6_wan_state /etc/init.d/service_wan_ipv6/default_ipv6_wan.sh`
         sysevent set ${SERVICE_NAME}_desired_ipv6_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async current_ipv6_link_state /etc/init.d/service_wan_ipv6/default_ipv6_wan.sh`
         sysevent set ${SERVICE_NAME}_current_ipv6_link_state_asyncid "$asyncid"
         ;;
      bridge)
         ulog ipv6 status "$PID installing handlers for bridge_link and bridge_wan"
         asyncid=`sysevent async phylink_wan_state /etc/init.d/service_wan_ipv6/bridge_link.sh`
         sysevent set ${SERVICE_NAME}_phylink_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async desired_ipv6_link_state /etc/init.d/service_wan_ipv6/bridge_link.sh`
         sysevent set ${SERVICE_NAME}_desired_ipv6_link_state_asyncid "$asyncid"
         asyncid=`sysevent async lan-status /etc/init.d/service_wan_ipv6/bridge_link.sh`
         sysevent set ${SERVICE_NAME}_lan-status_asyncid "$asyncid"
         asyncid=`sysevent async guest_access-status /etc/init.d/service_wan_ipv6/bridge_link.sh`
         sysevent set ${SERVICE_NAME}_guest_access-status_asyncid "$asyncid"
         asyncid=`sysevent async desired_ipv6_wan_state /etc/init.d/service_wan_ipv6/bridge_wan.sh`
         sysevent set ${SERVICE_NAME}_desired_ipv6_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async current_ipv6_link_state /etc/init.d/service_wan_ipv6/bridge_wan.sh`
         sysevent set ${SERVICE_NAME}_current_ipv6_link_state_asyncid "$asyncid"
         ;;
      6rd)
         ulog ipv6 status "$PID installing handlers for 6rd_ipv6_link and 6rd_ipv6_wan"
         asyncid=`sysevent async phylink_wan_state /etc/init.d/service_wan_ipv6/6rd_link.sh`
         sysevent set ${SERVICE_NAME}_phylink_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async wan-status /etc/init.d/service_wan_ipv6/6rd_link.sh`
         sysevent set ${SERVICE_NAME}_wan-status_asyncid "$asyncid"
         asyncid=`sysevent async desired_ipv6_link_state /etc/init.d/service_wan_ipv6/6rd_link.sh`
         sysevent set ${SERVICE_NAME}_desired_ipv6_link_state_asyncid "$asyncid"
         asyncid=`sysevent async lan-status /etc/init.d/service_wan_ipv6/6rd_link.sh`
         sysevent set ${SERVICE_NAME}_lan-status_asyncid "$asyncid"
         asyncid=`sysevent async guest_access-status /etc/init.d/service_wan_ipv6/6rd_link.sh`
         sysevent set ${SERVICE_NAME}_guest_access-status_asyncid "$asyncid"
         asyncid=`sysevent async desired_ipv6_wan_state /etc/init.d/service_wan_ipv6/6rd_wan.sh`
         sysevent set ${SERVICE_NAME}_desired_ipv6_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async current_ipv6_link_state /etc/init.d/service_wan_ipv6/6rd_wan.sh`
         sysevent set ${SERVICE_NAME}_current_ipv6_link_state_asyncid "$asyncid"
         ;;
      static)
         ulog ipv6 status "$PID installing handlers for static_ipv6_link and static_ipv6_wan"
         asyncid=`sysevent async phylink_wan_state /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_phylink_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async wan-status /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_wan-status_asyncid "$asyncid"
         asyncid=`sysevent async desired_ipv6_link_state /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_desired_ipv6_link_state_asyncid "$asyncid"
         asyncid=`sysevent async lan-status /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_lan-status_asyncid "$asyncid"
         asyncid=`sysevent async guest_access-status /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_guest_access-status_asyncid "$asyncid"
         asyncid=`sysevent async desired_ipv6_wan_state /etc/init.d/service_wan_ipv6/static_ipv6_wan.sh`
         sysevent set ${SERVICE_NAME}_desired_ipv6_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async current_ipv6_link_state /etc/init.d/service_wan_ipv6/static_ipv6_wan.sh`
         sysevent set ${SERVICE_NAME}_current_ipv6_link_state_asyncid "$asyncid"
         ;;
     *)
         ulog ipv6 status "$PID installing handlers for default_ipv6_link and default_ipv6_wan"
         asyncid=`sysevent async phylink_wan_state /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_phylink_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async wan-status /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_wan-status_asyncid "$asyncid"
         asyncid=`sysevent async desired_ipv6_link_state /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_desired_ipv6_link_state_asyncid "$asyncid"
         asyncid=`sysevent async lan-status /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_lan-status_asyncid "$asyncid"
         asyncid=`sysevent async guest_access-status /etc/init.d/service_wan_ipv6/default_ipv6_link.sh`
         sysevent set ${SERVICE_NAME}_guest_access-status_asyncid "$asyncid"
         asyncid=`sysevent async desired_ipv6_wan_state /etc/init.d/service_wan_ipv6/default_ipv6_wan.sh`
         sysevent set ${SERVICE_NAME}_desired_ipv6_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async current_ipv6_link_state /etc/init.d/service_wan_ipv6/default_ipv6_wan.sh`
         sysevent set ${SERVICE_NAME}_current_ipv6_link_state_asyncid "$asyncid"
         ;;
   esac
