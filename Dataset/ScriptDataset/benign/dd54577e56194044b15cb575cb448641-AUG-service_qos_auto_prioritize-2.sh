    cat <<EOF
lua /etc/init.d/service_qos_auto_prioritize/qos_update_priorities.lua ${DEVICE_ID}
rm ${PRUNE_CRON_FILE}
EOF
