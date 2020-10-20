   wait_till_end_state ${SERVICE_NAME}
   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "started" != "$STATUS" ] ; then
      SYSEVENT_ipv4_wan_ipaddr=`sysevent get ipv4_wan_ipaddr`
      SYSEVENT_ipv4_wan_subnet=`sysevent get ipv4_wan_subnet`
      if [ -n "$SYSEVENT_ipv4_wan_ipaddr" -a "0.0.0.0" != "$SYSEVENT_ipv4_wan_ipaddr" ] ; then
         if [ -z "$SYSEVENT_ipv4_wan_subnet" -o "0.0.0.0" = "$SYSEVENT_ipv4_wan_subnet" ] ; then
            SYSEVENT_ipv4_wan_subnet=255.255.255.0
         fi
         calculate_lan_networks $SYSEVENT_ipv4_wan_ipaddr $SYSEVENT_ipv4_wan_subnet
         if [ "$?" = "1" ] ; then
            ulog lan status "conflict between lan and wan ipv4 addresses detected and repaired"
            sysevent set lan-start
            exit
         fi
      fi
      do_start
      ERR=$?
      if [ "$ERR" -ne "0" ] ; then
         check_err $? "Unable to bringup lan"
      else
         sysevent set ${SERVICE_NAME}-started
         sysevent set ${SERVICE_NAME}-errinfo
         sysevent set ${SERVICE_NAME}-status started
         sysevent set reboot-status lan-started
         ulog lan status "reboot-status:lan-started"
         MODEL_NAME=`syscfg get device::model_base`
         if [ -z "$MODEL_NAME" ] ; then
            MODEL_NAME=`syscfg get device::modelNumber`
            MODEL_NAME=${MODEL_NAME%-*}
         fi
         if [ "$MODEL_NAME" != "PE10" ] ; then
            sysevent set system_state-normal
         fi
      fi
   fi
