   MAC_ADDR=$1
   ulog $SERVICE_NAME status "$PID lookup_ipv4_by_mac ($MAC_ADDR) -ENTER"
   if [ -f $FILE_FILE_LEASES ]; then
      DMZ_HOST_IPADDR=`cat $FILE_LEASES | grep $MAC_ADDR | awk '{ print $3 }'`     
   fi
   
   if [ -z $DMZ_HOST_IPADDR ] && [ -f $FILE_DETECTED ]; then
      DMZ_HOST_IPADDR=`cat $FILE_DETECTED | grep $MAC_ADDR | awk '{ print $3 }'`
   fi
   
   if [ -z $DMZ_HOST_IPADDR ] && [ -f $FILE_LANHOSTS ]; then
      DMZ_HOST_IPADDR=`cat $FILE_LANHOSTS | grep $MAC_ADDR | awk '{ print $1 }'`
   fi
   if [ -z $DMZ_HOST_IPADDR ]  ; then
      DMZ_HOST_IPADDR=` arp  | grep -i $DMZ_HOST_MACADDR | awk '{print $2}' | sed 's/(//' | sed 's/)//' | grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | sed 's/ //' `
   fi
   if [ -n $DMZ_HOST_IPADDR ]  ; then
      syscfg set dmz_dst_ip_addr ${DMZ_HOST_IPADDR}
      syscfg commit
   fi
   ulog $SERVICE_NAME status "$PID lookup_ipv4_by_mac ($DMZ_HOST_IPADDR) -EXIT"
   
   return
