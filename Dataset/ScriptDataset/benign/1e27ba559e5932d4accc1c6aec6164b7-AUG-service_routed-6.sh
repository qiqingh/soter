   if [ -n "$SYSCFG_hostname" ] ; then
      echo "hostname $SYSCFG_hostname" >> $ZEBRA_CONF_FILE
   fi
   echo "!password admin" >> $ZEBRA_CONF_FILE
   echo "!enable password admin" >> $ZEBRA_CONF_FILE
   echo "!log stdout" >> $ZEBRA_CONF_FILE
   echo "!log syslog" >> $ZEBRA_CONF_FILE
   echo "!log file /var/log/zebra.log" >> $ZEBRA_CONF_FILE
   if [ "" != "$SYSCFG_StaticRouteCount" ] && [ "0" != "$SYSCFG_StaticRouteCount" ] ; then
      WAN_IFNAME=`sysevent get current_wan_ifname`
      for ct in `seq 1 $SYSCFG_StaticRouteCount`
      do
         SR=StaticRoute_${ct}
         get_one_static_route_group $SR
         if [ "${?}" -ne "0" ] ; then
            ulog routed status "Failure in extracting static route info for $SR"
         else
            if [ "" = "$DEST" ] || [ "" = "$MASK" ] || [ "" = "$INTERFACE" ] ; then
               ulog routed status "Bad parameter for $NS"
            elif [ "lan" = "$INTERFACE" ] ; then
               if  [ "" = "$GW" ] ; then
                  ulog routed status "Bad parameter for $NS on $INTERFACE"
               else
                  echo "ip route $DEST $MASK $GW" >> $ZEBRA_CONF_FILE 
               fi
            elif [ "wan" = "$INTERFACE" ] ; then
               if [ "" = "$GW" ] || [ "0.0.0.0" = "$GW" ] ; then
                  echo "ip route $DEST $MASK $WAN_IFNAME" >> $ZEBRA_CONF_FILE 
               else
                  echo "ip route $DEST $MASK $GW" >> $ZEBRA_CONF_FILE 
               fi
            fi
         fi
      done
   fi
