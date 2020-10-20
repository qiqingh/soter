   mkdir -p $PPTP_PEERS_DIRECTORY
   echo -n > $PPTP_PEERS_FILE
   MODEL_NAME=`syscfg get device::modelNumber`
   if [ -n "$MODEL_NAME" ] ; then
       if [ "$MODEL_NAME" != "EA4500" -a "$MODEL_NAME" != "EA3500" -a "$MODEL_NAME" != "E4200" -a "$MODEL_NAME" != "E3200" ] ; then
           echo "plugin pptp.so" >> $PPTP_PEERS_FILE
           echo "pptp_server $SYSCFG_wan_proto_server_address" >> $PPTP_PEERS_FILE
       else
           echo "pty \"$PPTP_BIN $SYSCFG_wan_proto_server_address --nolaunchpppd\"" >> $PPTP_PEERS_FILE 
       fi
   fi
   echo "name \"$SYSCFG_wan_proto_username\""  >> $PPTP_PEERS_FILE
   REMOTE_NAME=$SYSCFG_wan_proto_remote_name
   if [ "" != "$REMOTE_NAME" ] ; then
      echo "remotename \"$REMOTE_NAME\"" >> $PPTP_PEERS_FILE
   fi
   echo "ipparam $PPTP_TUNNEL_NAME"  >> $PPTP_PEERS_FILE
