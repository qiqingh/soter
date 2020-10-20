   if [ -n "$2" ] ; then
      init_wan_namespace $2
      if [ 0 = "$?" -a -n "$SYSCFG_wan_proto" -a "none" != "$SYSCFG_wan_proto" ] ; then
         case "$1" in
            start)
               service_start
               ;;
            stop)
               service_stop
               ;;
         esac
      fi
   else
      MAX_WAN_COUNT=`syscfg get max_wan_count`
      if [ -z "$MAX_WAN_COUNT" ] ; then
         MAX_WAN_COUNT=0
      fi
      CUR_WAN_COUNT=1
      while [ $MAX_WAN_COUNT -ge $CUR_WAN_COUNT ] ; do
         i="wan_"${CUR_WAN_COUNT}
         CUR_WAN_COUNT=`expr $CUR_WAN_COUNT + 1`
         init_wan_namespace $i
         if [ 0 = "$?" -a -n "$SYSCFG_wan_proto" -a "none" != "$SYSCFG_wan_proto" ] ; then
            case "$1" in
               start)
                  service_start
                  ;;
               stop)
                  service_stop
                  ;;
               phylink_wan_state)
                  sysevent set ${i}_phylink_wan_state `sysevent get phylink_wan_state`
                  ;;
            esac
         fi
      done
   fi
