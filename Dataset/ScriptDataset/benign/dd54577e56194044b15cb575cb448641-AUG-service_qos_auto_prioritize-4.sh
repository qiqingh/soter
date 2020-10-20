    if [ ! -e ${PRUNE_CRON_FILE_ALL} -a ! -e ${PRUNE_CRON_FILE_DEVICE} ] ; then
        ulog ${SERVICE_NAME} status "scheduling cron for ${DEVICE_ID}"
        generate_cron_cron_file > ${PRUNE_CRON_FILE}
        chmod +x ${PRUNE_CRON_FILE}
    fi
