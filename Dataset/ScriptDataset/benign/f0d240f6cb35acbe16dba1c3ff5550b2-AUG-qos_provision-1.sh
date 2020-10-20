   if [ -n "$SYSCFG_wan_download_speed" ] ; then
      ROUNDED=`echo "$SYSCFG_wan_download_speed" | awk '{printf("%d\n",$1 + 0.5)}'`
   else 
      ROUNDED=0
   fi
   if [ "0" != "$ROUNDED" -a "$ROUNDED" -lt "$SYSCFG_dev_max_rate" ] ; then
      WAN_DESIRED_MBIT_RATE=`dc $SYSCFG_wan_download_speed $SYSEVENT_committed_bitrate - p`
      RES=`echo $WAN_DESIRED_MBIT_RATE | awk '{if (0 < $1) print 1; else print 0}'`
      if [ "$RES" = "0" ] ; then
         WAN_DESIRED_MBIT_RATE=".0001"
      fi
      GOLD_MIN=35
      SILVER_MIN=25
      BRONZE_MIN=15
      TIN_MIN=3
      TOTAL_MBIT=`dc $GOLD_RATE $SILVER_RATE + p`
      TOTAL_MBIT=`dc $TOTAL_MBIT $BRONZE_RATE + p`
      TOTAL_MBIT=`dc $TOTAL_MBIT $TIN_RATE + p`
      RES_MBIT=`dc $GOLD_MIN $SILVER_MIN + p`
      RES_MBIT=`dc $RES_MBIT $BRONZE_MIN + p`
      RES_MBIT=`dc $RES_MBIT $TIN_MIN + p`
      AVAIL_RATE_TO_WAN=`dc $AVAIL_RATE $RES_MBIT - p`
      RES=`echo $WAN_DESIRED_MBIT_RATE $TOTAL_MBIT | awk '{if ($1 > $2) print 1; else print 0}'`
      if [ "$RES" = "1" ] ; then
        WAN_DESIRED_MBIT_RATE=${TOTAL_MBIT} 
      fi
      RES=`echo $WAN_DESIRED_MBIT_RATE $AVAIL_RATE_TO_WAN | awk '{if ($1 > $2) print 1; else print 0}'`
      if [ "$RES" = "1" ] ; then
        WAN_DESIRED_MBIT_RATE=${AVAIL_RATE_TO_WAN} 
      fi
      RES=`echo $AVAIL_RATE_TO_WAN | awk '{if (0 < $1) print 1; else print 0}'`
      if [ -n $WAN_DESIRED_MBIT_RATE -a "$RES" = "1" ] ; then
         WAN_MBIT_RATE=${WAN_DESIRED_MBIT_RATE}"mbit"
         TIN_TMP=`dc $TIN_RATE  $TIN_MIN - p` 
         RES=`echo $WAN_DESIRED_MBIT_RATE $TIN_TMP | awk '{if ($1 <= $2) print 1; else print 0}'`
         if [ "$RES" = "1" ] ; then
            TIN_RATE=`dc $TIN_RATE  $WAN_DESIRED_MBIT_RATE - p`
         else
            TIN_RATE=$TIN_MIN
            WAN_DESIRED_MBIT_RATE=`dc $WAN_DESIRED_MBIT_RATE $TIN_TMP - p`
           
            RES=`echo $WAN_DESIRED_MBIT_RATE | awk '{if (0 < $1) print 1; else print 0}'`
            if [ "$RES" = "1" ] ; then
               BRONZE_TMP=`dc $BRONZE_RATE $BRONZE_MIN - p` 
               RES=`echo $WAN_DESIRED_MBIT_RATE $BRONZE_TMP | awk '{if ($1 <= $2) print 1; else print 0}'`
               if [ "$RES" = "1" ] ; then
                  BRONZE_RATE=`dc $BRONZE_RATE $WAN_DESIRED_MBIT_RATE - p`
               else
                  BRONZE_RATE=$BRONZE_MIN
                  WAN_DESIRED_MBIT_RATE=`dc $WAN_DESIRED_MBIT_RATE $BRONZE_TMP - p`
                  RES=`echo $WAN_DESIRED_MBIT_RATE | awk '{if (0 < $1) print 1; else print 0}'`
                  if [ "$RES" = "1" ] ; then
                     SILVER_TMP=`dc $SILVER_RATE $SILVER_MIN - p`
                     RES=`echo $WAN_DESIRED_MBIT_RATE $SILVER_TMP | awk '{if ($1 <= $2) print 1; else print 0}'`
                     if [ "$RES" = "1" ] ; then
                        SILVER_RATE=`dc $SILVER_RATE $WAN_DESIRED_MBIT_RATE - p`
                     else
                        SILVER_RATE=$SILVER_MIN
                        WAN_DESIRED_MBIT_RATE=`dc $WAN_DESIRED_MBIT_RATE $SILVER_TMP - p`
                        RES=`echo $WAN_DESIRED_MBIT_RATE | awk '{if (0 < $1) print 1; else print 0}'`
                        if [ "$RES" = "1" ] ; then
                           GOLD_RATE=`dc $GOLD_RATE $WAN_DESIRED_MBIT_RATE - p`
                           WAN_DESIRED_MBIT_RATE=0
                        fi
                     fi
                  fi
               fi
            fi
         fi
      fi
   fi
