   WARN_AT=$1
   RESTART_AT=$2
   
   cat << EOM > $IGD_MONITOR_FILE
   #!/bin/sh
   source /etc/init.d/date_functions.sh
   source /etc/init.d/ulog_functions.sh
   PID="(\$\$)"
   TOP_OUT="\`top -b -n 1 | grep [I]GD\`"
   IGD_PID="\`echo \$TOP_OUT | awk '{print \$1}'\`"
   CPU_USED="\`echo \$TOP_OUT | awk '{print \$8}' | cut -d. -f1\`"
   
   if [ \$CPU_USED -gt $WARN_AT ]; then
      ARCHIVE_ID=\`date '+%m%d_%H-%M-%S'\`
      ulog igd warning "\$PID detected CPU ABUSE: \$CPU_USED on \$ARCHIVE_ID"
   
      if [ \$CPU_USED -gt $RESTART_AT ]; then
         ulog igd error "\$PID restarting the IGD service"
         sysevent set igd-restart
      fi 
   fi
EOM
   chmod 755 $IGD_MONITOR_FILE
   cp $IGD_MONITOR_FILE $IGD_MONITOR_CRON_JOB
