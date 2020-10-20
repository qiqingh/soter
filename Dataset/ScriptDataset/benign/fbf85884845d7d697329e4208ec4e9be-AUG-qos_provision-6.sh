   DEV=$1
   SYSCFG_wan_download_speed=`syscfg get wan_download_speed`
   if [ -z "$SYSCFG_wan_download_speed" -o "0" = "$SYSCFG_wan_download_speed" ] ; then
      return
   fi
   
   calculate_wan_shaping_htb_qos_parameters $DEV
   if [ -n "$UNCLASSIFIED_WAN_MBIT_RATE" ] ; then
      tc class change dev ${DEV} parent 1:1 classid 1:50 htb rate $UNCLASSIFIED_WAN_MBIT_RATE ceil $UNCLASSIFIED_WAN_CEIL_RATE prio 5 
   fi
