   mkdir -p $PPP_PEERS_DIRECTORY
   echo -n > $PPPOE_PEERS_FILE
   INTERFACE_NAME=`syscfg get ${NAMESPACE} ifname`
   
   echo "plugin /lib/pppd/rp-pppoe.so" >> $PPPOE_PEERS_FILE
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
   MODEM_ENABLED=`syscfg get modem::enabled`
   MODEM_PROTOCOL=`syscfg get modem::protocol`
   MODEM_MAC=`sysevent get modem_mac`
   DEFAULT_SESSION_ID="154";
   if [ -n "$MODEM_ENABLED" -a "$MODEM_ENABLED" = "1" -a "$MODEM_PROTOCOL" = "pppoa" ] ; then
       echo "# pppoa exist session" >> $PPPOE_PEERS_FILE
       if [ -n "$DEFAULT_SESSION_ID" -a -n $MODEM_MAC ] ; then
           echo "rp_pppoe_sess $DEFAULT_SESSION_ID:$MODEM_MAC" >> $PPPOE_PEERS_FILE
       fi
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
