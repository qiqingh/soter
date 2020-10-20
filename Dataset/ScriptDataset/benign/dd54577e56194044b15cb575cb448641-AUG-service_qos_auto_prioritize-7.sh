    SYSCFG_FAILED='false'
    FOO=`utctx_cmd get qos_auto_prioritize_timestamp`
    eval $FOO
    if [ $SYSCFG_FAILED = 'true' ] ; then
        ulog lan status "$PID utctx_cmd failed to get qos_auto_prioritize_timestamp"
    else
        CURRENT_TIMESTAMP=`date +%s`
        if [ -z "$SYSCFG_qos_auto_prioritize_timestamp" ] || [ $SYSCFG_qos_auto_prioritize_timestamp -lt $CURRENT_TIMESTAMP ] ; then
            ulog ${SERVICE_NAME} status "deleting marked devices file"
            rm -rf /var/config/qos_marked_devices
            syscfg unset qos_auto_prioritize_timestamp
            syscfg commit
            schedule_cron
        fi
    fi
