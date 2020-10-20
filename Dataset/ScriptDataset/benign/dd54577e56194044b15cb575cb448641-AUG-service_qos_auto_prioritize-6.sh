    if [ -z "$DEVICE_ID" ] ; then
        clear_updates
    fi
    ulog ${SERVICE_NAME} status "scheduling update for ${DEVICE_ID}"
    generate_update_cron_file > ${PRUNE_CRON_FILE}
    chmod +x ${PRUNE_CRON_FILE}
