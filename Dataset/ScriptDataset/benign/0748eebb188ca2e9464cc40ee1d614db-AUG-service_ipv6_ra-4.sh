   CRON_FILE=$CRON_RETRY_FILE
   echo "#!/bin/sh" > $CRON_FILE
   echo "/etc/init.d/`basename $0` cron_handler" >> $CRON_FILE
   chmod 777 $CRON_FILE
