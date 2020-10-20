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
      MAX_COUNT=`syscfg get max_wan_count`
      if [ -z "$MAX_COUNT" ] ; then
         MAX_COUNT=0
      fi
      CURCOUNT=1
      while [ $MAX_COUNT -ge $CURCOUNT ] ; do
         i="wan_"${CURCOUNT}
         CURCOUNT=`expr $CURCOUNT + 1`
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
