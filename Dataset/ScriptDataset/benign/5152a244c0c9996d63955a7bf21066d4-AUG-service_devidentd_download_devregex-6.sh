    ulog ${SERVICE_NAME} status "checking timestamp"
    SYSEVENT_devidentd_download_devregex_timestamp=`sysevent get $DOWNLOAD_DEVREGEX_TIMESTAMP`
    CURRENT_TIMESTAMP=`date +%s`
    if [ ! -z "$SYSEVENT_devidentd_download_devregex_timestamp" ] && [ $SYSEVENT_devidentd_download_devregex_timestamp -lt $CURRENT_TIMESTAMP ] ; then
        download_devregex
        ulog ${SERVICE_NAME} status "creating timestamp between now and a week"
        UPPER_LIMIT_SECS=`expr 7 \\* 24 \\* 60 \\* 60` # a week
        NEXT_DOWNLOAD_TIMESTAMP=`lua $DEVIDENTD_CREATE_TIMESTAMP_FILE $UPPER_LIMIT_SECS`
        sysevent set $DOWNLOAD_DEVREGEX_TIMESTAMP $NEXT_DOWNLOAD_TIMESTAMP
        schedule_hourly_cron
    fi
