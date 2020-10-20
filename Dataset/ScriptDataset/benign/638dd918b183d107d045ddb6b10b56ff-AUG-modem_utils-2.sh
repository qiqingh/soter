	ulog wlan status "${SERVICE_NAME}, modem_detection()" > /dev/console
	RECONFIGURE="FALSE"
	if [ "`sysevent get phylink_wan_state`" = "down" ]; then
		sysevent set modem_detection_status "NOTFOUND"
	else
		RESULT=`is_modem_found`
		if 	[ "$?" = "1" ]; then
			sysevent set modem_detection_status "FOUND"
			MODEM_STATE=`sysevent get modem_state`
			if [ "$MODEM_STATE" = "NOTCONFIGURED" ]; then
				ulog wlan status "${SERVICE_NAME}, modem has not been configured"
				echo "${SERVICE_NAME}, modem has not been configured" > dev/console
				return 0
			elif [ "$MODEM_STATE" = "FAILED" ]; then
				ulog wlan status "${SERVICE_NAME}, previous modem configuration failed, reconfigure modem again"
				echo "${SERVICE_NAME}, previous modem configuration failed, reconfigure modem again" > dev/console
				RECONFIGURE="TRUE"
			else
				COMMAND1="sys tpget wan atm pvc disp 1"
				PVC1=`process_command "$COMMAND1"`
				if [ "$PVC1" != "FAIL" ]; then
					ulog wlan status "${SERVICE_NAME}, modem has been reset, reconfiguring it now"
					echo "${SERVICE_NAME}, modem has been reset, reconfiguring it now" > dev/console
					RECONFIGURE="TRUE"
				fi
				COMMAND="sys tpget wan atm pvc disp 0"
				PVC_VALUE=`process_command "$COMMAND"`
				MODEM_ENCAP="`echo $PVC_VALUE | awk -F"encap=" '{print $2}' | cut -d',' -f1`"
				MODEM_MODE="`echo $PVC_VALUE | awk -F"mode=" '{print $2}' | cut -d',' -f1`"
				MODEM_VPI="`echo $PVC_VALUE | awk -F"vpi=" '{print $2}' | cut -d',' -f1`"
				MODEM_VCI="`echo $PVC_VALUE | awk -F"vci=" '{print $2}' | cut -d',' -f1`"
				SYSCFG_VPI=`syscfg get modem::vpi`
				SYSCFG_VCI=`syscfg get modem::vci`
				if [ "`syscfg get modem::multiplexing`" = "llc" ]; then
					SYSCFG_ENCAP="0"
				else
					SYSCFG_ENCAP="1"
				fi	
				if [ "`syscfg_get modem::protocol`" = "pppoa" ] || [ "`syscfg_get modem::protocol`" = "ipoa" ]; then
					SYSCFG_MODE="1"
				else
					SYSCFG_MODE="0"
				fi
				if [ "$MODEM_VCI" != "$SYSCFG_VCI" ] || [ "$MODEM_VPI" != "$SYSCFG_VPI" ] || [ "$MODEM_ENCAP" != "$SYSCFG_ENCAP" ] || [ "$MODEM_MODE" != "$SYSCFG_MODE" ]; then
					ulog wlan status "${SERVICE_NAME}, configuration mismatch, reconfiguring it now"
					echo "${SERVICE_NAME}, configuration mismatch, reconfiguring it now" > dev/console
					RECONFIGURE="TRUE"
				fi
			fi
			if [ "$RECONFIGURE" = "TRUE" ]; then
				sysevent set modem_config_changed
				sysevent set wan-restart
			fi
		else
			ERROR_CODE=`echo $RESULT | awk -F":" '{print $1}'`
			case "$ERROR_CODE" in
				"Code 0x02")
					echo "${SERVICE_NAME}, Error: VLAN3 is not up, $RESULT" 1>&2
					ulog wlan status "${SERVICE_NAME}, Error: VLAN3 is not up, $RESULT" 1>&2
					sysevent set modem_detection_status "NOTFOUND"
					;;
				"Code 0x05")
					echo "${SERVICE_NAME}, Error: $RESULT" 1>&2
					ulog wlan status "${SERVICE_NAME}, Error: $RESULT" 1>&2
					sysevent set modem_detection_status "NOTFOUND"
					;;
				"Code 0x06")
					echo "${SERVICE_NAME}, Error: unknown device, $RESULT" 1>&2
					ulog wlan status "${SERVICE_NAME}, Error: unknown device, $RESULT" 1>&2
					sysevent set modem_detection_status "NOTFOUND"
					;;
				"Code 0x09")
					MODEM_PASSWORD=`syscfg_get modem::password`
					echo "${SERVICE_NAME}, Error: invalid password=$MODEM_PASSWORD, $RESULT" 1>&2
					ulog wlan status "${SERVICE_NAME}, Error: invalid password=$MODEM_PASSWORD, $RESULT" 1>&2
					sysevent set modem_detection_status "UNKNOWN"
					;;
				"")
					echo "${SERVICE_NAME}, Error: Failed to send" 1>&2
					ulog wlan status "${SERVICE_NAME}, Error: Failed to send" 1>&2
					sysevent set modem_detection_status "UNKNOWN"
					;;
				*)
					echo "${SERVICE_NAME}, Error: $RESULT" 1>&2
					ulog wlan status "${SERVICE_NAME}, Error: $RESULT" 1>&2
					sysevent set modem_detection_status "UNKNOWN"
			esac
		fi
	fi
	return 0
