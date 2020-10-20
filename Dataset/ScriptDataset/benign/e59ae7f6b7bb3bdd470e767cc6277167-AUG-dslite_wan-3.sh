   if [ -f $CRON_MONITOR_FILE ] ; then
      return 0
   fi
   echo "#!/bin/sh" > $CRON_MONITOR_FILE
   echo "ifconfig dslite  &> /dev/null" >>  $CRON_MONITOR_FILE
   echo "if [ \"\$?\" = \"0\" ] ; then" >> $CRON_MONITOR_FILE
   echo "   return 0" >> $CRON_MONITOR_FILE
   echo "fi" >> $CRON_MONITOR_FILE
   echo "VAL=\`sysevent get ${NAMESPACE}_desired_ipv4_wan_state\`" >> $CRON_MONITOR_FILE
   echo "if [ \"up\" = \"\$VAL\" ] ; then" >> $CRON_MONITOR_FILE
      echo "sysevent set ${NAMESPACE}_desired_ipv4_wan_state down" >> $CRON_MONITOR_FILE
      echo "sleep 5" >> $CRON_MONITOR_FILE
      echo "sysevent set ${NAMESPACE}_desired_ipv4_wan_state up" >> $CRON_MONITOR_FILE
   echo "fi" >> $CRON_MONITOR_FILE
  
   chmod 777 $CRON_MONITOR_FILE
