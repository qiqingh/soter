    nice -n -10 ${APP} &
    sysevent set $SERVICE_NAME-status started
