   LAN_ROUTE=`ip -6 route show | grep unreachable | awk '{ print $2 }'`
   for loop in $LAN_ROUTE
   do
       LINE=`ip -6 route show | grep unreachable | grep $loop`
       LINE=`echo $LINE | awk '{ print $2 " " $3 " " $4 }'`
       if [ -n "$LINE" ] ; then
          echo "delete unreachable route $LINE" > /dev/console
          ip -6 route del $LINE
       fi
   done
