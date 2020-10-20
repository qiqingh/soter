    eval `utctx_cmd get bridge_mode`
    if [ "$SYSCFG_bridge_mode" != "0" ] ; then
        ulog ${SERVICE_NAME} status "not running ${SERVICE_NAME} service because router is in bridge mode."
        return 0
    fi
    if [ ! -e /tmp/${DEVREGEX_FILE} ] ; then
        ln -s /etc/${DEVREGEX_FILE} /tmp/${DEVREGEX_FILE}
    fi
    wait_till_end_state ${SERVICE_NAME}
    STATUS=`sysevent get ${SERVICE_NAME}-status`
    if [ "started" != "$STATUS" ] ; then
        sysevent set ${SERVICE_NAME}-errinfo
        sysevent set ${SERVICE_NAME}-status starting
        ulog ${SERVICE_NAME} status "starting ${SERVICE_NAME} service"
        eval `utctx_cmd get lan_ifname`
        ${BIN} -x ${DOWNLOADED_DEVREGEX_FILE} -r /tmp/${DEVREGEX_FILE} -p ${PID_FILE} ${SYSCFG_lan_ifname}
        echo 1 > /proc/sys/net/ipv4/conf/all/arp_accept
        check_err $? "Couldnt handle start"
        sysevent set ${SERVICE_NAME}-status started
    fi
    if [ ! -e ${PRUNE_CRON_FILE} ] ; then
        ln -s ${DEVICE_PRUNE_SCRIPT} ${PRUNE_CRON_FILE}
    fi
    $PMON setproc ${SERVICE_NAME} $BIN $PID_FILE "/etc/init.d/service_${SERVICE_NAME}.sh ${SERVICE_NAME}-restart"
