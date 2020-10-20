    ulog ${SERVICE_NAME} status "checking timestamp"
    SYSCFG_FAILED='false'
    FOO=`utctx_cmd get devidentd_download_devregex_timestamp`
    eval $FOO
    if [ $SYSCFG_FAILED = 'true' ] ; then
        ulog lan status "$PID utctx_cmd failed to get devidentd_download_devregex_timestamp"
    else
        CURRENT_TIMESTAMP=`date +%s`
        if [ ! -z "$SYSCFG_devidentd_download_devregex_timestamp" ] && [ $SYSCFG_devidentd_download_devregex_timestamp -lt $CURRENT_TIMESTAMP ] ; then
            download_devregex
            ulog ${SERVICE_NAME} status "creating timestamp between now and a week"
            UPPER_LIMIT_SECS=`expr 7 \\* 24 \\* 60 \\* 60` # a week
            NEXT_DOWNLOAD_TIMESTAMP=`lua $DEVIDENTD_CREATE_TIMESTAMP_FILE $UPPER_LIMIT_SECS`
            FOO=`utctx_cmd set devidentd_download_devregex_timestamp=$NEXT_DOWNLOAD_TIMESTAMP`
            schedule_hourly_cron
        fi
    fi
