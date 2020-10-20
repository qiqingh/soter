    ulog ${SERVICE_NAME} status "clearing all pending device QoS priority updates"
    rm -f ${PRUNE_CRON_MIN_DIR}/qos_update_priorities*.sh
