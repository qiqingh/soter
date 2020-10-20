    check_timestamp
    if [ ! -e ${PRUNE_CRON_FILE_CHECK_TIMESTAMP} ] ; then
        ulog ${SERVICE_NAME} status "scheduling timestamp check"
        generate_timestamp_cron_file > ${PRUNE_CRON_FILE_CHECK_TIMESTAMP}
        chmod +x ${PRUNE_CRON_FILE_CHECK_TIMESTAMP}
    fi
