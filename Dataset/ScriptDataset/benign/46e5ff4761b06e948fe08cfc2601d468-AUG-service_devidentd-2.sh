    if [ -e ${PRUNE_CRON_FILE} ] ; then
        rm ${PRUNE_CRON_FILE}
    fi
    wait_till_end_state ${SERVICE_NAME}
    STATUS=`sysevent get ${SERVICE_NAME}-status`
    if [ "stopped" != "$STATUS" ] ; then
        sysevent set ${SERVICE_NAME}-errinfo
        sysevent set ${SERVICE_NAME}-status stopping
        ulog ${SERVICE_NAME} status "stopping ${SERVICE_NAME} service"
        kill -TERM $(cat $PID_FILE)
        echo 0 > /proc/sys/net/ipv4/conf/all/arp_accept
        check_err $? "Couldnt handle stop"
        sysevent set ${SERVICE_NAME}-status stopped
    fi
    rm -f $PID_FILE
    $PMON unsetproc ${SERVICE_NAME}
