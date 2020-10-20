   if [ -f $RETRY_START_FILENAME ]; then
      return
   fi
   ulog $SERVICE_NAME status "Creating cron job to retry service start ($RETRY_START_FILENAME)"
   cat > $RETRY_START_FILENAME << EOF
#!/bin/sh
source /etc/init.d/ulog_functions.sh
ulog ${SERVICE_NAME} status "Retrying ${SERVICE_NAME}-start"
sysevent set ${SERVICE_NAME}-start
EOF
   chmod 700 $RETRY_START_FILENAME
