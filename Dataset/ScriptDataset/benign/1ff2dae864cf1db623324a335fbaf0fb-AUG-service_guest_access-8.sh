	if [ "0" = "`syscfg get bridge_mode`" ] && [ "started" != "`sysevent get lan-status`" ] ; then
		ulog guest_access status "${SERVICE_NAME}, LAN is not started,ignore the request"
		return
	fi
	if [ "0" = "$SYSCFG_guest_enabled" ] ; then
		sysevent set guest_access-status disabled
		return
	fi
	if [ "down" = "$SYSCFG_wl0_state" ] ; then	
		sysevent set guest_access-status stopped
		return
	fi
	wait_till_end_state ${SERVICE_NAME}
	STATUS=`sysevent get ${SERVICE_NAME}-status`
	if [ "started" != "$STATUS" ] ; then
		sysevent set ${SERVICE_NAME}-status starting
		do_start
		sysevent set ${SERVICE_NAME}-status started
		if [ "0" != "$SYSCFG_guest_enabled" ] && [ "`syscfg get bridge_mode`" != "0" ] ; then
			echo 1 > /proc/sys/net/ipv4/ip_forward
		fi
		sysevent set firewall-restart
	fi