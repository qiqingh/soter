	if [ ! -f $WAN_LOG_FILE ];then
		touch $WAN_LOG_FILE
	fi
	WAN_TYPE=`syscfg get wan_type`
	PPP_STATUS=`sysevent get ppp_status`
	PREV_PPP_STATUS=`sysevent get prev_ppp_status`
	if [ -z $PREV_PPP_STATUS ];then
		PREV_PPP_STATUS="down"
		sysevent set prev_ppp_status down
	fi
