   INDEX_DHCP=1
   INDEX_STATIC=1
   while [ $INDEX_DHCP -le 3 ]; do
      NTP_SERVER=`sysevent get dhcpc_ntp_server$INDEX_DHCP`
      if [ "" = "$NTP_SERVER" -o "0.0.0.0" = "$NTP_SERVER" ]; then
         INDEX_DHCP=`expr $INDEX_DHCP + 1`
      else
         RESULT=`ntpclient -h $NTP_SERVER -i 10 -s`
         if [ "" = "$RESULT" ]; then
            INDEX_DHCP=`expr $INDEX_DHCP + 1`
         else
            `sysevent set ntp_pool_index $INDEX_DHCP`
            return 0
         fi
      fi
   done
   while [ $INDEX_STATIC -le 3 ]; do
      NTP_SERVER=`syscfg get ntp_server$INDEX_STATIC`
      if [ "" = "$NTP_SERVER" -o "0.0.0.0" = "$NTP_SERVER" ]; then
         INDEX_STATIC=`expr $INDEX_STATIC + 1`
      else
         RESULT=`ntpclient -h $NTP_SERVER -i 10 -s`
         if [ "" = "$RESULT" ]; then
            INDEX_STATIC=`expr $INDEX_STATIC + 1`
         else
            `sysevent set ntp_pool_index $INDEX_STATIC`
            return 0
         fi
      fi
   done
