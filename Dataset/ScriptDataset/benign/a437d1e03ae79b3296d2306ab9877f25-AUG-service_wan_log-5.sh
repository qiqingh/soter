    	ulog ${SERVICE_NAME} STATUS "STOP requested"
	if [ -z $PPP_STATUS ];then
		if [ "x"$PREV_PPP_STATUS = "xup" ];then
			sysevent set prev_ppp_status down
			log_wan_down
		fi
		return;
	fi
	if [ $PPP_STATUS = $PREV_PPP_STATUS ];then
		return;
   	fi
	if [ $PPP_STATUS = "up" ] && [ $PREV_PPP_STATUS = "down" ];then
		sysevent set prev_ppp_status up
		log_wan_up
		return;
	fi
        if [ $PPP_STATUS = "down" ] && [ $PREV_PPP_STATUS = "up" ];then
		sysevent set prev_ppp_status down
                log_wan_down
                return;
        fi

