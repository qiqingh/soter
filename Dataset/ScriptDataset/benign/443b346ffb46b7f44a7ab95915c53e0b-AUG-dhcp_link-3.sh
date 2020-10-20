   ulog dhcp_link status "stopping dhcp client on bridge"
   if [ -f "$UDHCPC_PID_FILE" ] ; then
      kill -USR2 `cat $UDHCPC_PID_FILE` && kill `cat $UDHCPC_PID_FILE`
      rm -f $UDHCPC_PID_FILE
   else
      killall -USR2 udhcpc && killall udhcpc
      rm -f $UDHCPC_PID_FILE
   fi
   rm -f $LOG_FILE
    sysevent set current_ipv4_wan_state down
