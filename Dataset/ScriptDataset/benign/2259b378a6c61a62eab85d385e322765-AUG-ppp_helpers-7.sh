   echo -n > $PPP_PAP_SECRETS_FILE
   echo -n > $PPP_CHAP_SECRETS_FILE
   REMOTE_NAME=$SYSCFG_wan_proto_remote_name
   if [ "" = "$REMOTE_NAME" ] ; then
      REMOTE_NAME=*
   fi
   LINE="\"$SYSCFG_wan_proto_username\" $REMOTE_NAME \"$SYSCFG_wan_proto_password\" *"
   echo "$LINE" >> $PPP_PAP_SECRETS_FILE
   echo "$LINE" >> $PPP_CHAP_SECRETS_FILE
   chmod 600 $PPP_PAP_SECRETS_FILE
   chmod 600 $PPP_CHAP_SECRETS_FILE
