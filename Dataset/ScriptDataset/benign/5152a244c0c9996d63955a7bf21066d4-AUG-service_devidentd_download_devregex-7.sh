    check_timestamp
    if [ ! -e ${PRUNE_CRON_FILE_CHECK_TIMESTAMP_EVERY_MINUTE} ] ; then
        ulog ${SERVICE_NAME} status "creating timestamp between now and an hour"
        UPPER_LIMIT_SECS=`expr 1 \\* 60 \\* 60` # 1 hour
        NEXT_DOWNLOAD_TIMESTAMP=`lua $DEVIDENTD_CREATE_TIMESTAMP_FILE $UPPER_LIMIT_SECS`
        sysevent set $DOWNLOAD_DEVREGEX_TIMESTAMP $NEXT_DOWNLOAD_TIMESTAMP
    fi
