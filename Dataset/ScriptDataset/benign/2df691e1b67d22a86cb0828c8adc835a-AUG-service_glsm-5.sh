   wait_till_end_state ${SERVICE_NAME}
   SYSCFG_glsm_enable=`syscfg get glsm_enable`
   if [ "$SYSCFG_glsm_enable" != "1" ]; then
	return
   fi
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] ; then
        killall -q generic_link_status_monitor
        sysevent set ${SERVICE_NAME}-status starting
        do_start
   fi       
