   DDNS_STATE_RESTORED=`sysevent get ddns_state_restored`
   if [ -z "$DDNS_STATE_RESTORED" ]; then
      ulog ddns status "$PID restoring the ddns state"
      if [ -d $DDNS_PERSIST_DIR ]; then
         ulog ddns status "$PID recovering the ddns state"
         cp -prf ${DDNS_PERSIST_DIR}/*.* $DDNS_TMP_DIR 
                
         if [ "$SYSCFG_ddns_service" == "tzo" ]; then
            ulog ddns status "$PID recovering the tzo conf file"
            make_tzo_conf_file $CONF_FILE
            sysevent set ddns_state_restored 1
         elif [ "$SYSCFG_ddns_service" == "noip" ]; then
            ulog ddns status "$PID recovering the noip conf file"
            make_noip_conf_file $CONF_FILE
            sysevent set ddns_state_restored 1
         else
            ddns_ipv4=`cat $CACHE_FILE | awk -F ',' '{print $2}'`
            if [ -z "$WAN_IFNAME" ]; then
               ulog ddns status "$PID wan_ifname is not set; let's wait"
               wait_for_wan_ifname
            fi
            if [ -n "$WAN_IFNAME" ]; then
               ulog ddns status "$PID recovering the dyndns conf file with ($ddns_ipv4)"
               make_ez_ipupdate_conf_file $CONF_FILE $ddns_ipv4
               sysevent set ddns_state_restored 1
            fi   
         fi   
      fi
   fi
