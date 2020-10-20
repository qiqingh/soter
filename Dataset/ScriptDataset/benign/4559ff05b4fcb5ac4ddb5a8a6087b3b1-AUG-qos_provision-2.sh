   SYSCFG_dev_max_rate=`syscfg get ${1}_dev_max_rate`
   SYSCFG_wan_download_speed=`syscfg get wan_download_speed`
   SYSCFG_dev_avail_percent=`syscfg get ${1}_dev_avail_percent`
   if [ -z "$SYSCFG_dev_avail_percent" ] ; then 
      SYSCFG_dev_avail_percent=100
   fi
   SYSEVENT_unclassified_wan_ceiling_percent=`sysevent get unclassified_wan_ceiling_percent`
   if [ -z "$SYSEVENT_unclassified_wan_ceiling_percent" ] ; then
      SYSEVENT_unclassified_wan_ceiling_percent=100
   fi
   SYSCFG_gold_percent=`syscfg get ${1}_gold_percent`
   SYSCFG_silver_percent=`syscfg get ${1}_silver_percent`
   SYSCFG_bronze_percent=`syscfg get ${1}_bronze_percent`
   SYSCFG_tin_percent=`syscfg get ${1}_tin_percent`
   SYSEVENT_committed_bitrate=`sysevent get committed_bitrate`
   if [ -z "$SYSCFG_dev_max_rate" ] ; then
      SYSCFG_dev_max_rate=1000
   fi
   if [ -z "$SYSCFG_wan_download_speed" ] ; then
      SYSCFG_wan_download_speed=$SYSCFG_dev_max_rate
   fi
   if [ -z "$SYSCFG_gold_percent" ] ; then
      SYSCFG_gold_percent=60
   fi
   if [ -z "$SYSCFG_silver_percent" ] ; then
      SYSCFG_silver_percent=25
   fi
   if [ -z "$SYSCFG_bronze_percent" ] ; then
      SYSCFG_bronze_percent=10
   fi
   if [ -z "$SYSCFG_tin_percent" ] ; then
      SYSCFG_tin_percent=5
   fi
   if [ -z "$SYSEVENT_committed_bitrate" ] ; then
      SYSEVENT_committed_bitrate=0
   fi
   RES=`echo $SYSCFG_wan_download_speed $SYSCFG_dev_max_rate | awk '{if ($1 > $2) print 1; else print 0}'`
   if [ "$RES" = "1" ] ; then
      AVAIL_RATE=$SYSCFG_dev_max_rate 
   else
      AVAIL_RATE=$SYSCFG_wan_download_speed
   fi
   AVAIL_RATE=`dc $AVAIL_RATE  $SYSCFG_dev_avail_percent 100 / \* p`
   GOLD_RATE=`dc $AVAIL_RATE  $SYSCFG_gold_percent 100 / \* p`
   SILVER_RATE=`dc $AVAIL_RATE  $SYSCFG_silver_percent 100 / \* p`
   BRONZE_RATE=`dc $AVAIL_RATE  $SYSCFG_bronze_percent 100 / \* p`
   TIN_RATE=`dc $AVAIL_RATE  $SYSCFG_tin_percent 100 / \* p`
   WAN_DESIRED_MBIT_RATE=".0001"
   GOLD_RATE=`dc $GOLD_RATE $WAN_DESIRED_MBIT_RATE - p`
   if [ -n "$SYSEVENT_committed_bitrate" ] ; then
      UNCLASSIFIED_WAN_CEIL=`dc $AVAIL_RATE $SYSEVENT_committed_bitrate - p`
   else
      UNCLASSIFIED_WAN_CEIL=$AVAIL_RATE
   fi
   UNCLASSIFIED_WAN_CEIL=`dc $UNCLASSIFIED_WAN_CEIL $SYSEVENT_unclassified_wan_ceiling_percent 100 / \* p`
   RES=`echo $WAN_DESIRED_MBIT_RATE $UNCLASSIFIED_WAN_CEIL | awk '{if ($1 > $2) print 1; else print 0}'`
   if [ "$RES" = "1" ] ; then
      UNCLASSIFIED_WAN_CEIL=$WAN_DESIRED_MBIT_RATE
   fi
   AVAIL_MBIT_RATE=${AVAIL_RATE}"mbit"
   GOLD_MBIT_RATE=${GOLD_RATE}"mbit"
   SILVER_MBIT_RATE=${SILVER_RATE}"mbit"
   BRONZE_MBIT_RATE=${BRONZE_RATE}"mbit"
   TIN_MBIT_RATE=${TIN_RATE}"mbit"
   UNCLASSIFIED_WAN_MBIT_RATE=${WAN_DESIRED_MBIT_RATE}"mbit"
   UNCLASSIFIED_WAN_CEIL_RATE=${UNCLASSIFIED_WAN_CEIL}"mbit"
