   SYSCFG_num_static_hosts=`syscfg get dhcp_num_static_hosts`
   echo -n > $LOCAL_DHCP_STATIC_HOSTS_FILE
   for N in $(seq 1 $SYSCFG_num_static_hosts)
   do
      HOST_LINE=`syscfg get dhcp_static_host_$N`
      if [ -n "$HOST_LINE" -a "none" != "$HOST_LINE" ] ; then
         MAC=""
         SAVEIFS=$IFS
         IFS=,
         set -- $HOST_LINE
         MAC=$1
         shift
         make_ip_using_subnet $LAN_NETWORK $SYSEVENT_lan_prefix_len $1
         IP=$CREATED_IP_ADDRESS
         shift
         FRIENDLY_NAME=$1
         IFS=$SAVEIFS
         echo "$MAC,$IP,$FRIENDLY_NAME" >> $LOCAL_DHCP_STATIC_HOSTS_FILE
      fi
   done
   HOST_LINE=`syscfg get lan_ipaddr`
   if [ -n "$HOST_LINE" ]
   then
      echo "lan_ipaddr, $HOST_LINE" >> $LOCAL_DHCP_STATIC_HOSTS_FILE
   fi
   HOST_LINE=`syscfg get guest_lan_ipaddr`
   if [ -n "$HOST_LINE" ]
   then
      echo "guest_lan_ipaddr, $HOST_LINE" >> $LOCAL_DHCP_STATIC_HOSTS_FILE
   fi
   cat $LOCAL_DHCP_STATIC_HOSTS_FILE > $DHCP_STATIC_HOSTS_FILE
   rm -f $LOCAL_DHCP_STATIC_HOSTS_FILE
