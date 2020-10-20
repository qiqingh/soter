   mkdir -p $L2TP_PEERS_DIRECTORY
   mkdir -p $L2TP_CONF_DIR
   echo -n > $L2TP_CONF_FILE
   echo "global" >> $L2TP_CONF_FILE
   echo "load-handler "sync-pppd.so"" >> $L2TP_CONF_FILE
   echo "load-handler "cmd.so"" >> $L2TP_CONF_FILE
   echo "listen-port 1701" >> $L2TP_CONF_FILE
   echo "section sync-pppd" >> $L2TP_CONF_FILE
   MODEL_NAME=`syscfg get device::model_base`
   if [ -z "$MODEL_NAME" ] ; then
        MODEL_NAME=`syscfg get device::modelNumber`
   fi
   if [ -n "$MODEL_NAME" ] ; then
       if [ "$MODEL_NAME" != "EA6500" -a "$MODEL_NAME" != "EA2700" -a "$MODEL_NAME" != "EA2700OQ" ] ; then
           if [ "`syscfg get kernel_mode_l2tp`" != "0" ];then
	           echo "kernel-mode 1" >> $L2TP_CONF_FILE
	       else
	           echo "kernel-mode 0" >> $L2TP_CONF_FILE
	       fi
	   fi
   fi
   echo "lac-pppd-opts \"file /etc/ppp/options\"" >> $L2TP_CONF_FILE
   echo "section peer" >> $L2TP_CONF_FILE
   L2TP_SERVER_IP=$SYSCFG_wan_proto_server_address
   echo "peer $L2TP_SERVER_IP" >> $L2TP_CONF_FILE
   echo "port 1701" >> $L2TP_CONF_FILE
   echo "lac-handler sync-pppd" >> $L2TP_CONF_FILE
   echo "lns-handler sync-pppd" >> $L2TP_CONF_FILE
   echo "hide-avps yes" >> $L2TP_CONF_FILE
   echo "section cmd" >> $L2TP_CONF_FILE
