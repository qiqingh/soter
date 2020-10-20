    wait_till_end_state ${SERVICE_NAME}
    sysevent set ${SERVICE_NAME}-status "starting"
    ulog ${SERVICE_NAME} status "starting ${SERVICE_NAME} service"
    if [ "$qos_enabled" = "1" ]; then
        switch_sfe_off
        sysevent set ${SERVICE_NAME}-status "stopped"
        return
    fi
    switch_sfe_on
    sysevent set ${SERVICE_NAME}-status "started"
