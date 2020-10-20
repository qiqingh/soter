   DHCP_SLOW_START_1_FILE=/etc/cron/cron.everyminute/dhcp_slow_start.sh
   DHCP_SLOW_START_2_FILE=/etc/cron/cron.every5minute/dhcp_slow_start.sh
   DHCP_SLOW_START_3_FILE=/etc/cron/cron.every10minute/dhcp_slow_start.sh
   DHCP_LEASE_TIME=
   SLOW_START=`syscfg get dhcp_server_slow_start`
   if [ "1" = "$SLOW_START" -a "started" != "`sysevent get ntpclient-status`" ] ; then
      DHCP_SLOW_START_NEEDED=1
   fi
   PROPAGATE_NS=`syscfg get dhcp_server_propagate_wan_nameserver`
   if [ "1" != "$PROPAGATE_NS" ] ; then
      PROPAGATE_NS=`syscfg get block_nat_redirection`
   fi
   if [ "1" = "$DHCP_SLOW_START_NEEDED" ] ; then
      DHCP_SLOW_START_QUANTA=`sysevent get dhcp_slow_start_quanta`
      if [ -z "$DHCP_SLOW_START_QUANTA" ] ; then
         TIME_FILE=$DHCP_SLOW_START_1_FILE
         sysevent set dhcp_slow_start_quanta 1
         DHCP_LEASE_TIME=1m
      else
         if [ "$DHCP_SLOW_START_QUANTA" -lt "$SLOW_START_NUM_TRIES_1" ] ; then
            TIME_FILE=$DHCP_SLOW_START_1_FILE
            DHCP_LEASE_TIME=1m
         elif [ "$DHCP_SLOW_START_QUANTA" -eq "$SLOW_START_NUM_TRIES_1" ] ; then
            TIME_FILE=$DHCP_SLOW_START_2_FILE
            sysevent set dhcp_slow_start_quanta 6
            DHCP_LEASE_TIME=5m
         elif [ "$DHCP_SLOW_START_QUANTA" -lt "$SLOW_START_NUM_TRIES_2" ] ; then
            TIME_FILE=$DHCP_SLOW_START_2_FILE
            DHCP_LEASE_TIME=5m
         elif [ "$DHCP_SLOW_START_QUANTA" -eq "$SLOW_START_NUM_TRIES_2" ] ; then
            TIME_FILE=$DHCP_SLOW_START_3_FILE
            sysevent set dhcp_slow_start_quanta 8
            DHCP_LEASE_TIME=10m
         elif [ "$DHCP_SLOW_START_QUANTA" -lt "$SLOW_START_NUM_TRIES_3" ] ; then
            TIME_FILE=$DHCP_SLOW_START_3_FILE
            DHCP_LEASE_TIME=10m
         elif [ "$DHCP_SLOW_START_QUANTA" -ge "$SLOW_START_NUM_TRIES_3" ] ; then
            DHCP_SLOW_START_NEEDED=
            TIME_FILE=
            sysevent set dhcp_slow_start_quanta
            DHCP_LEASE_TIME=
         fi
      fi
   else
      sysevent set dhcp_slow_start_quanta
   fi
   if [ -z "$DHCP_LEASE_TIME" ] ; then
      DHCP_LEASE_TIME=`syscfg get dhcp_lease_time`
   fi
   if [ -z "$DHCP_LEASE_TIME" ] ; then
      DHCP_LEASE_TIME=86400
   fi
   case $DHCP_LEASE_TIME in
       *h) DHCP_LEASE_TIME=$(expr ${DHCP_LEASE_TIME%%h} \* 3600)
           ;;
       *m) DHCP_LEASE_TIME=$(expr ${DHCP_LEASE_TIME%%m} \* 60)
           ;;
       *s) DHCP_LEASE_TIME=${DHCP_LEASE_TIME%%s}
           ;;
   esac
   
   sysevent set lan_dhcp_lease $DHCP_LEASE_TIME
