   gen_authfile "$SYSCFG_http_admin_user" "$SYSCFG_http_admin_password" "encoded"
   PORT=$SYSCFG_http_admin_port
   if [ "" = "$PORT" ] ; then
      PORT=80
   fi
   echo "nochroot" >> $CONF_FILE
   echo "port=$PORT" >> $CONF_FILE
   echo "dir=/www" >> $CONF_FILE
   echo "data_dir=/www" >> $CONF_FILE
   echo "user=root" >> $CONF_FILE
   echo "logfile=$LOG_FILE" >> $CONF_FILE
   echo "pidfile=$PID_FILE" >> $CONF_FILE
   echo "cgipat=cgi-bin/*|**.cgi" >> $CONF_FILE
   $BIN -C $CONF_FILE
