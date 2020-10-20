    killall -15 ${BIN}
    sysevent set $SERVICE_NAME-status stopped
