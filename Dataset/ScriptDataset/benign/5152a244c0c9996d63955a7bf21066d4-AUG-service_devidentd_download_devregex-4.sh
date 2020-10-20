    ulog ${SERVICE_NAME} status "scheduling hourly cron"
    if [ ! -e ${PRUNE_CRON_FILE_CHECK_TIMESTAMP_HOURLY} ]; then
        generate_timestamp_cron_file > ${PRUNE_CRON_FILE_CHECK_TIMESTAMP_HOURLY}
        chmod +x ${PRUNE_CRON_FILE_CHECK_TIMESTAMP_HOURLY}
    fi
