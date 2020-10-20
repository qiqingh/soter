    wait_till_end_state ${SERVICE_NAME}
    STATUS=`sysevent get ${SERVICE_NAME}-status`
    if [ "started" != "$STATUS" ] ; then
        sysevent set ${SERVICE_NAME}-errinfo
        sysevent set ${SERVICE_NAME}-status starting
        ulog ${SERVICE_NAME} status "starting ${SERVICE_NAME} service"
        generate_conf > ${CONF_FILE}
        ${BIN} ${CONF_FILE} 2&> /dev/null &
        check_err $? "Couldnt handle start"
        sysevent set ${SERVICE_NAME}-status started
    fi
    $PMON setproc ${SERVICE_NAME} $BIN $PID_FILE "/etc/init.d/service_${SERVICE_NAME}.sh ${SERVICE_NAME}-restart"
