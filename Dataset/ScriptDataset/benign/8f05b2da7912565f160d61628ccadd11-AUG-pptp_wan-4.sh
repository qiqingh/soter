   mkdir -p $PPTP_PEERS_DIRECTORY
   echo -n > $PPTP_PEERS_FILE
   echo "plugin pptp.so" >> $PPTP_PEERS_FILE
   echo "pptp_server $SYSCFG_wan_proto_server_address" >> $PPTP_PEERS_FILE
   echo "name $SYSCFG_wan_proto_username"  >> $PPTP_PEERS_FILE
   REMOTE_NAME=$SYSCFG_wan_proto_remote_name
   if [ "" != "$REMOTE_NAME" ] ; then
      echo "remotename \"$REMOTE_NAME\"" >> $PPTP_PEERS_FILE
   fi
   echo "ipparam $PPTP_TUNNEL_NAME"  >> $PPTP_PEERS_FILE
