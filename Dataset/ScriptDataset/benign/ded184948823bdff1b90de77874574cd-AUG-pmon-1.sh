   for i in 1 2 3 4 6 8 1 1 1 1 1 1 1 1 1 1 
   do
      SYSTEM_STATUS=`sysevent ping`
      if [ "$SYSTEM_STATUS" = "SUCCESS" ] ; then
         return
      fi
      sleep $i
   done
   [ -f /usr/sbin/se_post.sh ] && /usr/sbin/se_post.sh &
   sleep 3
   reboot
   exit
