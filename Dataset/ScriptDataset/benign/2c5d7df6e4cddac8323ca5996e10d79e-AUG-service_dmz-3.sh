   DMZ_ENABLED=`syscfg get dmz_enabled`
   : ${DMZ_ENABLED:=0}
   
   ulog $SERVICE_NAME status "$PID get_dmz_host () -ENTER"
   if [ "$DMZ_ENABLED" == "1" ] ; then
      DMZ_HOST_IPADDR=`syscfg get dmz_dst_ip_addr`
      if [ -z $DMZ_HOST_IPADDR ] || [ "$DMZ_HOST_IPADDR" == "0" ] || [ "$DMZ_HOST_IPADDR" == "0.0.0.0" ]; then
         DMZ_HOST_MACADDR=`syscfg get dmz_dst_mac_addr`
         if [ -z $DMZ_HOST_MACADDR ]; then
            ulog $SERVICE_NAME error "$PID DMZ is enabled but not provisioned ($DMZ_HOST_IPADDR) ($DMZ_HOST_MACADDR)"
            DMZ_ENABLED=0
         else
            lookup_ipv4_by_mac  $DMZ_HOST_MACADDR
         fi
      fi
   fi
   ulog $SERVICE_NAME status "$PID get_dmz_host ($DMZ_ENABLED,$DMZ_HOST_IPADDR) -EXIT"
   return $DMZ_ENABLED
