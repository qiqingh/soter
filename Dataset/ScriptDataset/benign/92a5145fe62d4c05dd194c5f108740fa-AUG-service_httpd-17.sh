    wait_till_end_state ${SERVICE_NAME}
    sysevent set ${SERVICE_NAME}-errinfo
    sysevent set ${SERVICE_NAME}-status stopping
    STATUS=`sysevent get ${SERVICE_NAME}-status`
    if [ "stopped" != "$STATUS" ] ; then
    ulog ${SERVICE_NAME} status "stopping ${SERVICE_NAME} service"
    define_lighttpd_env
    if [ -f "$PID_FILE" ] ; then
            do_stop_lighttpd
    fi
    $PMON unsetproc httpd
    sysevent set ${SERVICE_NAME}-errinfo
    sysevent set ${SERVICE_NAME}-status "stopped"
    fi
