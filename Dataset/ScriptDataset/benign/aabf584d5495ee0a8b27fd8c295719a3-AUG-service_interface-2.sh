   if [ -n "$1" ] ; then
      MAX_COUNT=`syscfg get max_interface_count`
      if [ -z "$MAX_COUNT" ] ; then
         MAX_COUNT=0
      fi
      CURCOUNT=1
      while [ $MAX_COUNT -ge $CURCOUNT ] ; do
         NS="interface_"${CURCOUNT}
         CURCOUNT=`expr $CURCOUNT + 1`
        eval `utctx_cmd get ${NS}::ifname`
        eval `echo SYSCFG_ifname='$'SYSCFG_${NS}_ifname`
        if [ "$SYSCFG_ifname" = "$1" ] ; then
           echo $NS
           return 0
        fi
      done
   fi
