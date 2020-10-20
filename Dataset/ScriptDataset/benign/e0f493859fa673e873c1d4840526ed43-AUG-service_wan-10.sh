   if [ -z "$1" ] ; then
      ulog wan status "$PID register_handlers called without parameter. Ignoring"
      return
   else
      ulog wan status "$PID register_handlers for wan $1"
   fi
   sysevent setoptions ${1}_desired_ipv4_link_state $TUPLE_FLAG_EVENT
   sysevent setoptions ${1}_desired_ipv4_wan_state $TUPLE_FLAG_EVENT
   if [ "pppoe" = "$SYSCFG_wan_proto" -o "pptp" = "$SYSCFG_wan_proto" -o "l2tp" = "$SYSCFG_wan_proto" -o "dhcp" = "$SYSCFG_wan_proto" -o "static" = "$SYSCFG_wan_proto" ] ; then
      HW_VENDOR=`syscfg get hardware_vendor_name`
      if [ -n "$HW_VENDOR" -a "$HW_VENDOR" = "Broadcom" ] ; then
          nvram set wan_proto="$SYSCFG_wan_proto"
          nvram commit
      fi
   fi
   case "$SYSCFG_wan_proto" in
      dhcp)
         ulog wan status "$PID installing handlers for dhcp_link and dhcp_wan $1"
         if [ "1" = "$SYSCFG_default" ] ; then
            register_dhcp_client_handlers $1
            asyncid=`sysevent async dhcp_default_router_changed /etc/init.d/service_wan/wan_status_monitor.sh`
            sysevent setoptions dhcp_default_router_changed $TUPLE_FLAG_EVENT
            sysevent set dhcp_default_router_changed_asyncid "$asyncid"
         fi
         asyncid=`sysevent async ${1}_phylink_wan_state /etc/init.d/service_wan/dhcp_link.sh`
         sysevent set ${1}_phylink_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_desired_ipv4_link_state /etc/init.d/service_wan/dhcp_link.sh`
         sysevent set ${1}_desired_ipv4_link_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_desired_ipv4_wan_state /etc/init.d/service_wan/dhcp_wan.sh`
         sysevent set ${1}_desired_ipv4_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_current_ipv4_link_state /etc/init.d/service_wan/dhcp_wan.sh`
         sysevent set ${1}_current_ipv4_link_state_asyncid "$asyncid"
         ;;
      static)
         ulog wan status "$PID installing handlers for static_link and static_wan $1"
         asyncid=`sysevent async ${1}_phylink_wan_state /etc/init.d/service_wan/static_link.sh`
         sysevent set ${1}_phylink_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_desired_ipv4_link_state /etc/init.d/service_wan/static_link.sh`
         sysevent set ${1}_desired_ipv4_link_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_desired_ipv4_wan_state /etc/init.d/service_wan/static_wan.sh`
         sysevent set ${1}_desired_ipv4_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_current_ipv4_link_state /etc/init.d/service_wan/static_wan.sh`
         sysevent set ${1}_current_ipv4_link_state_asyncid "$asyncid"
         ;;
      pppoe)
         ulog wan status "$PID installing handlers for pppoe_link and pppoe_wan $1"
         asyncid=`sysevent async ${1}_phylink_wan_state /etc/init.d/service_wan/pppoe_link.sh`
         sysevent set ${1}_phylink_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_desired_ipv4_link_state /etc/init.d/service_wan/pppoe_link.sh`
         sysevent set ${1}_desired_ipv4_link_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_desired_ipv4_wan_state /etc/init.d/service_wan/pppoe_wan.sh`
         sysevent set ${1}_desired_ipv4_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_current_ipv4_link_state /etc/init.d/service_wan/pppoe_wan.sh`
         sysevent set ${1}_current_ipv4_link_state_asyncid "$asyncid"
         ;;
      pptp)
         if [ "0" != "$SYSCFG_pptp_address_static" ] ; then
            ulog wan status "$PID installing handlers for static_link and pptp_wan $1"
            asyncid=`sysevent async ${1}_phylink_wan_state /etc/init.d/service_wan/static_link.sh`
            sysevent set ${1}_phylink_wan_state_asyncid "$asyncid"
            asyncid=`sysevent async ${1}_desired_ipv4_link_state /etc/init.d/service_wan/static_link.sh`
            sysevent set ${1}_desired_ipv4_link_state_asyncid "$asyncid"
         else
            ulog wan status "$PID installing handlers for dhcp_link and pptp_wan"
            if [ "1" = "$SYSCFG_default" ] ; then
               register_dhcp_client_handlers $1 
            fi
            asyncid=`sysevent async ${1}_phylink_wan_state /etc/init.d/service_wan/dhcp_link.sh`
            sysevent set ${1}_phylink_wan_state_asyncid "$asyncid"
            asyncid=`sysevent async ${1}_desired_ipv4_link_state /etc/init.d/service_wan/dhcp_link.sh`
            sysevent set ${1}_desired_ipv4_link_state_asyncid "$asyncid"
         fi
         asyncid=`sysevent async ${1}_desired_ipv4_wan_state /etc/init.d/service_wan/pptp_wan.sh`
         sysevent set ${1}_desired_ipv4_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_current_ipv4_link_state /etc/init.d/service_wan/pptp_wan.sh`
         sysevent set ${1}_current_ipv4_link_state_asyncid "$asyncid"
         ;;
      l2tp)
         if [ "0" != "$SYSCFG_l2tp_address_static" ] ; then
            ulog wan status "$PID installing handlers for static_link and l2tp_wan $1"
            asyncid=`sysevent async ${1}_phylink_wan_state /etc/init.d/service_wan/static_link.sh`
            sysevent set ${1}_phylink_wan_state_asyncid "$asyncid"
            asyncid=`sysevent async ${1}_desired_ipv4_link_state /etc/init.d/service_wan/static_link.sh`
            sysevent set ${1}_desired_ipv4_link_state_asyncid "$asyncid"
         else
            ulog wan status "$PID installing handlers for dhcp_link and l2tp_wan"
            if [ "1" = "$SYSCFG_default" ] ; then
               register_dhcp_client_handlers $1 
            fi
            asyncid=`sysevent async ${1}_phylink_wan_state /etc/init.d/service_wan/dhcp_link.sh`
            sysevent set ${1}_phylink_wan_state_asyncid "$asyncid"
            asyncid=`sysevent async ${1}_desired_ipv4_link_state /etc/init.d/service_wan/dhcp_link.sh`
            sysevent set ${1}_desired_ipv4_link_state_asyncid "$asyncid"
         fi
         asyncid=`sysevent async ${1}_desired_ipv4_wan_state /etc/init.d/service_wan/l2tp_wan.sh`
         sysevent set ${1}_desired_ipv4_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_current_ipv4_link_state /etc/init.d/service_wan/l2tp_wan.sh`
         sysevent set ${1}_current_ipv4_link_state_asyncid "$asyncid"
         ;;
      dslite)
         ulog wan status "$PID installing handlers for dslite_link and dslite_wan $1"
         asyncid=`sysevent async ${1}_phylink_wan_state /etc/init.d/service_wan/dslite_link.sh`
         sysevent set ${1}_phylink_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_desired_ipv4_link_state /etc/init.d/service_wan/dslite_link.sh`
         sysevent set ${1}_desired_ipv4_link_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_desired_ipv4_wan_state /etc/init.d/service_wan/dslite_wan.sh`
         sysevent set ${1}_desired_ipv4_wan_state_asyncid "$asyncid"
         asyncid=`sysevent async ${1}_current_ipv4_link_state /etc/init.d/service_wan/dslite_wan.sh`
         sysevent set ${1}_current_ipv4_link_state_asyncid "$asyncid"
         ;;
      telstra)
         ulog wan status "$PID telstra_wan is deprecated. Not setting up interface $1"
         ;;
   esac
