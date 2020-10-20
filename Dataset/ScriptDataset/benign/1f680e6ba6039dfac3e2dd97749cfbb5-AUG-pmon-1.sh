   for i in 1 2 3 4 6 8 1 1 1 1 1 1 1 1 1 1 
   do
      SYSTEM_STATUS=`sysevent ping`
      if [ "$SYSTEM_STATUS" = "SUCCESS" ] ; then
         return
      fi
      sleep $i
   done
   reboot
   exit
