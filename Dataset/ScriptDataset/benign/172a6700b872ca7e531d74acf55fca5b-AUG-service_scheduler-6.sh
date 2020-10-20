	if [ "`syscfg_get wifi_scheduler::enabled`" != "1" ]; then
		return 0;
	fi
	
	DAY=`date +%a`
	HOUR=`date +%k`
	MINUTE=`date +%M`
	case "$DAY" in
		Mon)
			DAY_RULES=`syscfg_get wifi_scheduler::monday_time_blocks`
			;;			
		Tue)
			DAY_RULES=`syscfg_get wifi_scheduler::tuesday_time_blocks`
			;;			
		Wed)
			DAY_RULES=`syscfg_get wifi_scheduler::wednesday_time_blocks`
			;;			
		Thu)
			DAY_RULES=`syscfg_get wifi_scheduler::thursday_time_blocks`
			;;			
		Fri)
			DAY_RULES=`syscfg_get wifi_scheduler::friday_time_blocks`
			;;			
		Sat)
			DAY_RULES=`syscfg_get wifi_scheduler::saturday_time_blocks`
			;;			
		Sun)
			DAY_RULES=`syscfg_get wifi_scheduler::sunday_time_blocks`
			;;			
		*)
			echo"${SERVICE_NAME}, ERROR: Invalid day of week=$DAY"
			return 1
			;;
	esac
	if [ "${#DAY_RULES}" != "48" ]; then
		echo "${SERVICE_NAME}, invalid rules format, day=${DAY}: rules=${DAY_RULES}"
		ulog ${SERVICE_NAME} status "${SERVICE_NAME}, invalid rules format, day=${DAY}: rules=${DAY_RULES}"
		return 1
	fi
	if [ "${MINUTE}" -lt "30" ]; then
		RULE_INDEX=`expr $HOUR \* 2`      # first byte
	else
		RULE_INDEX=`expr $HOUR \* 2 + 1`  # second byte
	fi
	RULE=`echo ${DAY_RULES:$RULE_INDEX:1}`
		
	if [ "${RULE}" = "0" ] && [ "`sysevent get wifi-status`" != "stopping" ] && [ "`sysevent get wifi-status`" != "stopped" ] ; then
		sysevent set wifi-stop
	fi
	if [ "${RULE}" = "1" ] && [ "`sysevent get wifi-status`" != "starting" ] && [ "`sysevent get wifi-status`" != "started" ] ; then
		sysevent set wifi-start
	fi
		
	return 0
