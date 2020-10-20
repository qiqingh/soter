   MAX_COUNT=`syscfg get max_wan_count`
   if [ -z "$MAX_COUNT" ] ; then
      MAX_COUNT=0
   fi
   CURCOUNT=1
   while [ $MAX_COUNT -ge $CURCOUNT ] ; do
      i="wan_"${CURCOUNT}
      CURCOUNT=`expr $CURCOUNT + 1`
      wan_info_by_namespace_local $i 
      if [ "0" = "$?" ] ; then
         DO_STATIC_NAMESERVERS=0
         case "$SYSCFG_LOCAL_wan_proto" in
            static)
               DO_STATIC_NAMESERVERS=1
               ;;
            pptp)
               if [ "1" = "$SYSCFG_LOCAL_pptp_address_static" ] ; then
                  DO_STATIC_NAMESERVERS=1
               fi
               ;;
            l2tp)
               if [ "1" = "$SYSCFG_LOCAL_l2tp_address_static" ] ; then
                  DO_STATIC_NAMESERVERS=1
               fi
               ;;
         esac
         if [ "1" = "$DO_STATIC_NAMESERVERS" ] ; then
            if [ -n "$SYSCFG_LOCAL_nameserver1" ]  && [ "0.0.0.0" !=  "$SYSCFG_LOCAL_nameserver1" ] ; then
               echo "nameserver $SYSCFG_LOCAL_nameserver1" >> $TEMP_RESOLV_CONF
            fi
            if [ -n "$SYSCFG_LOCAL_nameserver2" ]  && [ "0.0.0.0" !=  "$SYSCFG_LOCAL_nameserver2" ] ; then
               echo "nameserver $SYSCFG_LOCAL_nameserver2" >> $TEMP_RESOLV_CONF
            fi
            if [ -n "$SYSCFG_LOCAL_nameserver3" ]  && [ "0.0.0.0" !=  "$SYSCFG_LOCAL_nameserver3" ] ; then
               echo "nameserver $SYSCFG_LOCAL_nameserver3" >> $TEMP_RESOLV_CONF
            fi
         fi   
      fi
   done
