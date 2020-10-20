    ulog ${SERVICE_NAME} status "clearing all schedules"
    if [ -e ${PRUNE_CRON_FILE_CHECK_TIMESTAMP_EVERY_MINUTE} ] ; then
        rm -f $PRUNE_CRON_FILE_CHECK_TIMESTAMP_EVERY_MINUTE
    fi
    if [ -e ${PRUNE_CRON_FILE_CHECK_TIMESTAMP_HOURLY} ] ; then
        rm -f ${PRUNE_CRON_FILE_CHECK_TIMESTAMP_HOURLY}
    fi
    syscfg unset devidentd_download_devregex_timestamp
    syscfg commit
