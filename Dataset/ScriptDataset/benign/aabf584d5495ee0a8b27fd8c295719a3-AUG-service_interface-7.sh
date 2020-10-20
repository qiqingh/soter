   if [ -n "$2" ] ; then
      init_interface_namespace $2
      if [ 0 = "$?" ] ; then
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
      MAX_COUNT=`syscfg get max_interface_count`
      if [ -z "$MAX_COUNT" ] ; then
         MAX_COUNT=0
      fi
      CURCOUNT=1
      while [ $MAX_COUNT -ge $CURCOUNT ] ; do
         i="interface_"${CURCOUNT}
         CURCOUNT=`expr $CURCOUNT + 1`
         init_interface_namespace $i
         if [ 0 = "$?" ] ; then
            case "$1" in
               start)
                  service_start
                  ;;
               stop)
                  service_stop
                  ;;
            esac
         fi
      done
   fi
