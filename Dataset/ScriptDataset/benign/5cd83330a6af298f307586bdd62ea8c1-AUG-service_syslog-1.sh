   killall syslogd > /dev/null 2>&1
   if [ "" = "$SYSCFG_log_level" ] ; then
       SYSCFG_log_level=1
   fi
   if [ "" = "$SYSCFG_log_remote" ] ; then
       SYSCFG_log_remote=0
   fi
   case "$SYSCFG_log_level" in
       0) SYSLOG_LEVEL=4 ;;
       1) SYSLOG_LEVEL=5 ;;
       2) SYSLOG_LEVEL=6 ;;
       3) SYSLOG_LEVEL=7 ;;
       *) SYSLOG_LEVEL=5 ;;
   esac
   BB_SYSLOG_LEVEL=`expr $SYSLOG_LEVEL + 1`
   if [ "0" != "$SYSCFG_log_remote" ] ; then
       /sbin/syslogd -l $BB_SYSLOG_LEVEL -L -R $SYSCFG_log_remote
   else
      /sbin/syslogd -l $BB_SYSLOG_LEVEL
   fi
   if [ "1" = "$USE_SYSEVENT" ] ; then
      sysevent set ${SERVICE_NAME}-status "started"
   fi
