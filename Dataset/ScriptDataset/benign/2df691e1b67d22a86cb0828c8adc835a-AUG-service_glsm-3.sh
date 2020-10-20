    ulog glsm status "shutdown glsm"
    sysevent set ${SERVICE_NAME}-status stopped
    killall -q generic_link_status_monitor
