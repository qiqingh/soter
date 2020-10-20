    wait_till_end_state ${SERVICE_NAME}
    sysevent set ${SERVICE_NAME}-status "starting"
    ulog ${SERVICE_NAME} status "starting ${SERVICE_NAME} service"
    if [ "$service_enable" != "1" -o \
         "$SYSCFG_User_Accepts_WiFi_Is_Unsecure" != "1" -o \
         "$qos_enabled" = "1" ]; then
        switch_ctf_off
        sysevent set ${SERVICE_NAME}-status "stopped"
        return
    fi
    if [ "$CTF_BYPASS_SUPPORTED" != "1" -a \
         "$SYSCFG_parental_control_enabled" = "1" ]; then
        switch_ctf_off
        sysevent set ${SERVICE_NAME}-status "stopped"
        return
    fi
    switch_ctf_on
    sysevent set ${SERVICE_NAME}-status "started"
