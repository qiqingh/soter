   echo "#!/bin/sh" > $CRON_TIMEOUT_FILE
   echo "VAL=\`sysevent get ${NAMESPACE}_current_ipv4_link_state\`" >> $CRON_TIMEOUT_FILE
   echo "if [ \"up\" = \"\$VAL\" ] ; then" >> $CRON_TIMEOUT_FILE
      echo "sysevent set ${NAMESPACE}_nslookup_retry ${NAMESPACE}" >> $CRON_TIMEOUT_FILE
   echo "fi" >> $CRON_TIMEOUT_FILE
   chmod 777 $CRON_TIMEOUT_FILE
