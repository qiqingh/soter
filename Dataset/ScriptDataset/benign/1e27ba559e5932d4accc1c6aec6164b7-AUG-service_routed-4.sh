   TRIES=`sysevent get zebra_ra_cron_reties`
   if [ -z "$TRIES" ] ; then
      TRIES=0
      sysevent set zebra_ra_cron_reties $TRIES
   fi
   if [ "5" -ge "$TRIES" ] ; then
      CRON_FILE=$CRON_RETRY_FILE_1
   elif [ "10" -ge "$TRIES" ] ; then
      CRON_FILE=$CRON_RETRY_FILE_2
   elif [ "15" -ge "$TRIES" ] ; then
      CRON_FILE=$CRON_RETRY_FILE_3
   else
      CRON_FILE=$CRON_RETRY_FILE_4
   fi
   echo "#!/bin/sh" > $CRON_FILE
   echo "/etc/init.d/`basename $0` cron_handler $TRIES" >> $CRON_FILE
   chmod 777 $CRON_FILE
