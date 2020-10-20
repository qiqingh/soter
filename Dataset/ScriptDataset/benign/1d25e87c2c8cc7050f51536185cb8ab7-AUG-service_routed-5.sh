   clean_cron_retry_file
   TRIES=$1
   TRIES=`expr $TRIES + 1`
   ip -6 route show | grep default
   RES=$?
   if [ "0" = "$RES" ] ; then
      sysevent set routed-restart
   else
      sysevent set zebra_ra_cron_reties $TRIES
      make_cron_retry_file
   fi
