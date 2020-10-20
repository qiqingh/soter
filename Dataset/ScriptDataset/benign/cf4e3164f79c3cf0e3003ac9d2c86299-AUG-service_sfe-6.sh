    wait_till_end_state ${SERVICE_NAME}
    sysevent set ${SERVICE_NAME}-status "stopping"
    ulog ${SERVICE_NAME} status "stopping ${SERVICE_NAME} service"
    switch_sfe_off
    sysevent set ${SERVICE_NAME}-status "stopped"
