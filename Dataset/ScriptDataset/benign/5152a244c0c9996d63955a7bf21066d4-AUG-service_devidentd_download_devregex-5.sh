    ulog ${SERVICE_NAME} status "scheduling every minute cron"
    if [ ! -e ${PRUNE_CRON_FILE_CHECK_TIMESTAMP_EVERY_MINUTE} ]; then
        generate_timestamp_cron_file > ${PRUNE_CRON_FILE_CHECK_TIMESTAMP_EVERY_MINUTE}
        chmod +x ${PRUNE_CRON_FILE_CHECK_TIMESTAMP_EVERY_MINUTE}
    fi
