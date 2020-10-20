   SYSCFG_wan_download_speed=`syscfg get wan_download_speed`
   SYSCFG_dev_max_rate=`syscfg get ${1}_dev_max_rate`
   SYSCFG_gold_percent=`syscfg get ${1}_gold_percent`
   SYSCFG_silver_percent=`syscfg get ${1}_silver_percent`
   SYSCFG_bronze_percent=`syscfg get ${1}_bronze_percent`
   SYSCFG_tin_percent=`syscfg get ${1}_tin_percent`
   SYSEVENT_committed_bitrate=`sysevent get committed_bitrate`
   SYSCFG_hardware_vendor_name=`syscfg get hardware_vendor_name`
   if [ -z "$SYSCFG_hardware_vendor_name" -o "Broadcom" = "$SYSCFG_hardware_vendor_name" ] ; then  
      if [ -z "$SYSCFG_dev_max_rate" -o "0" = "$SYSCFG_dev_max_rate" ] ; then
         DEV=$1
         wl -i $DEV status|grep -q 80MHz
         if [ $? -eq 0 ] ; then
            SYSCFG_dev_max_rate="500"
         fi
         wl -i $DEV status|grep -q 40MHz
         if [ $? -eq 0 ] ; then
            SYSCFG_dev_max_rate="250"
         fi
         wl -i $DEV status|grep -q 20MHz
         if [ $? -eq 0 ] ; then
            SYSCFG_dev_max_rate="155"
         fi
      fi
   fi
   if [ -z "$SYSCFG_dev_max_rate" ] ; then
      SYSCFG_dev_max_rate="250"
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
      SYSEVENT_committed_bitrate="0"
   fi
   AVAIL_RATE=`dc $SYSCFG_dev_max_rate  $SYSEVENT_committed_bitrate - p`
   GOLD_RATE=`dc $AVAIL_RATE  $SYSCFG_gold_percent 100 / \* p`
   SILVER_RATE=`dc $AVAIL_RATE  $SYSCFG_silver_percent 100 / \* p`
   BRONZE_RATE=`dc $AVAIL_RATE  $SYSCFG_bronze_percent 100 / \* p`
   TIN_RATE=`dc $AVAIL_RATE  $SYSCFG_tin_percent 100 / \* p`
   adjust_queues_for_unclassified_wan
   AVAIL_MBIT_RATE=${AVAIL_RATE}"mbit"
   GOLD_MBIT_RATE=${GOLD_RATE}"mbit"
   SILVER_MBIT_RATE=${SILVER_RATE}"mbit"
   BRONZE_MBIT_RATE=${BRONZE_RATE}"mbit"
   TIN_MBIT_RATE=${TIN_RATE}"mbit"
