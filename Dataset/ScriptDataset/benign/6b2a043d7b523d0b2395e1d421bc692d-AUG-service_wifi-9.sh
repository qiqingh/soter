	ulog wlan status "${SERVICE_NAME}, start_hostapd()"
	echo "${SERVICE_NAME}, start_hostapd()"
	USE_HOSTAPD=`syscfg_get wl_use_hostapd`
	HOSTAPD_CONF_LIST=""
	if [ "1" = "$USE_HOSTAPD" ]; then
		WL0STATE=`syscfg_get wl0_state`
		WL1STATE=`syscfg_get wl1_state`
		WL0SEC_MODE=`get_security_mode wl0_security_mode`
		WL1SEC_MODE=`get_security_mode wl1_security_mode`
		if [ "up" = "$WL0STATE" ] && [ "8" != "$WL0SEC_MODE" ] && [ ! -z "`echo $PHYSICAL_IF_LIST | grep ath0`" ]; then
			HOSTAPD_CONF_LIST="/tmp/hostapd-ath0.conf"
			PROC_PID_LINE=`ps | grep "hostapd-mon -v -0 /tmp/hostapd-ath0.conf" | grep -v grep`
			PROC_PID=`echo $PROC_PID_LINE |  awk '{print $1}'`
			if [ -z "$PROC_PID" ]; then
				hostapd-mon -v -0 /tmp/hostapd-ath0.conf &
			fi
			ulog wlan status "${SERVICE_NAME}, add ath0 to hostapd_conf_list, starting hostapd-mon for ath0"
		fi
		if [ "up" = "$WL1STATE" ] && [ "8" != "$WL1SEC_MODE" ] && [ ! -z "`echo $PHYSICAL_IF_LIST | grep ath1`" ]; then
			HOSTAPD_CONF_LIST="`echo $HOSTAPD_CONF_LIST` /tmp/hostapd-ath1.conf"
			PROC_PID_LINE=`ps | grep "hostapd-mon -v -1 /tmp/hostapd-ath1.conf" | grep -v grep`
			PROC_PID=`echo $PROC_PID_LINE |  awk '{print $1}'`
			if [ -z "$PROC_PID" ]; then
				hostapd-mon -v -1 /tmp/hostapd-ath1.conf &
			fi
			ulog wlan status "${SERVICE_NAME}, add ath1 to hostapd_conf_list, starting hostapd-mon for ath1"
		fi
		if [ "" != "$HOSTAPD_CONF_LIST" ]; then
			ulog wlan status "${SERVICE_NAME}, starting hostapd with $HOSTAPD_CONF_LIST"
			HOSTAPD_DEBUG=`syscfg_get wl_hostapd_debug`
			if [ ! -z "$HOSTAPD_DEBUG" ]; then
				HOSTAPD_CONF_LIST="`echo $HOSTAPD_DEBUG` `echo $HOSTAPD_CONF_LIST`"
			fi
			hostapd $HOSTAPD_CONF_LIST &
			sleep 2
		fi
		if [ "up" = "$WL0STATE" ] && [ "0" = "$WL0SEC_MODE" ] && [ ! -z "`echo $PHYSICAL_IF_LIST | grep ath0`" ]; then
			iwconfig ath0 key off
		fi
		if [ "up" = "$WL1STATE" ] && [ "0" = "$WL1SEC_MODE" ] && [ ! -z "`echo $PHYSICAL_IF_LIST | grep ath1`" ]; then
			iwconfig ath1 key off
		fi
		if [ "1" = "`syscfg_get guest_enabled`" ] && [ "1" = "`syscfg_get wl1_guest_enabled`" ] ; then
			GUEST_VAP=`syscfg_get wl1_guest_vap`
			iwconfig $GUEST_VAP freq 0
		fi
		if [ "1" = "`syscfg_get guest_enabled`" ] && [ "1" = "`syscfg_get wl0_guest_enabled`" ] ; then
			GUEST_VAP=`syscfg_get wl0_guest_vap`
			iwconfig $GUEST_VAP freq 0
		fi
	fi
