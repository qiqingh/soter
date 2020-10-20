   mkdir -p $PPP_PEERS_DIRECTORY
   echo -n > $PPPOE_PEERS_FILE
   echo "plugin /lib/pppd/rp-pppoe.so" >> $PPPOE_PEERS_FILE
   INTERFACE_NAME=`syscfg get ${NAMESPACE} ifname`
   echo "# Ethernet interface name" >> $PPPOE_PEERS_FILE
   echo "$INTERFACE_NAME" >> $PPPOE_PEERS_FILE
   echo "user \"$SYSCFG_wan_proto_username\"" >> $PPPOE_PEERS_FILE
   REMOTE_NAME=$SYSCFG_wan_proto_remote_name
   if [ "" != "$REMOTE_NAME" ] ; then
      echo "remotename \"$REMOTE_NAME\"" >> $PPPOE_PEERS_FILE
   fi
   if [ "" != "$SYSCFG_pppoe_service_name" ] ; then
      echo "rp_pppoe_service \"$SYSCFG_pppoe_service_name\"" >> $PPPOE_PEERS_FILE
   fi
   if [ "" != "$SYSCFG_pppoe_access_concentrator_name" ] ; then
      echo "rp_pppoe_ac \"$SYSCFG_pppoe_access_concentrator_name\"" >> $PPPOE_PEERS_FILE
   fi
   echo "noauth" >> $PPPOE_PEERS_FILE
   echo "hide-password" >> $PPPOE_PEERS_FILE
   echo "updetach" >> $PPPOE_PEERS_FILE
   echo "debug" >> $PPPOE_PEERS_FILE
   if [ "1" = "$SYSCFG_default" ] ; then
      echo "defaultroute" >> $PPP_PEERS_FILE
   fi
   echo "noipdefault" >> $PPPOE_PEERS_FILE
   echo "usepeerdns" >> $PPPOE_PEERS_FILE
