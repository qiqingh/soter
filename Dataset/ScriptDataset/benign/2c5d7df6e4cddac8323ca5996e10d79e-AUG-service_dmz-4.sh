   DMZ_HOST_IP=$1
   ulog $SERVICE_NAME status "$PID check_firewall_rules ($DMZ_HOST_IP) -ENTER"
   KEY=`echo $DMZ_HOST_IP | sed 's/\./\\\./g'`
   RULES=`iptables -L -nv | grep wan2lan.*$KEY`
   
   ulog $SERVICE_NAME status "$PID check_firewall_rules () -EXIT"
   
   if [ "$RULES" == "" ]; then
      return 0;
   fi
   return 1;
