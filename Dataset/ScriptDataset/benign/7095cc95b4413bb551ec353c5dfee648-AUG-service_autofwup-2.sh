	UPTIME=`cat /proc/uptime | cut -d'.' -f1`
	BASETIME="60"
	if [ $UPTIME -lt $BASETIME ]; then
		return 0
	fi
	
	pidof fwupd > /dev/null
	if [ $? != "0" ] 
	then
		CHECK_AFTER_BOOT=`sysevent get fwup_checked_after_boot`
		if [ "${CHECK_AFTER_BOOT}" = "0" ]; then
			Debug "fwup_checked_after_boot: 0"
			sysevent set fwup_periodic_check 0
			local SYS_FORCED_UPDATE_STATUS="fwup_forced_update_status"
			local FORCED_UPDATE_STATUS=$(syscfg get "$SYS_FORCED_UPDATE_STATUS")
			case "$FORCED_UPDATE_STATUS" in
				"" | 1)
					if [ "$FORCED_UPDATE_STATUS" == 1 ]; then		
						syscfg set fwup_firmware_version 1
					fi
					fwupd -m 3
					FORCED_UPDATE=`sysevent get fwup_forced_update`
					Debug "fwup_forced_update:" $FORCED_UPDATE
					if [ "$FORCED_UPDATE" != "0" ]; then
						sleep 2
						syscfg set fwup_firmware_version 1
						fwupd -m 4 -d &
						sysevent set fwup_periodic_check "done"
					else
						if [ "$(syscfg get fwup_newfirmware_version)" ]; then
							syscfg unset "$SYS_FORCED_UPDATE_STATUS"
						fi
					fi	
					;;	
				0)
					Debug "Forced firmware upate: done"
					Debug	
					syscfg unset "$SYS_FORCED_UPDATE_STATUS"
					syscfg commit
					sleep 4
					sysevent set fwupd-success 2
					sysevent set fwup_periodic_check "done"
					sysevent set fwup_checked_after_boot 1
					;;
				*)
					;;
			esac
		else
			PERIODIC_CHECK=$(sysevent get fwup_periodic_check)
			NODES_MODE=$(syscfg get smart_mode::mode)
			case "$PERIODIC_CHECK" in
				"update")
					Debug "Automatic update"
					sysevent set fwup_periodic_check
					if [ "$NODES_MODE" == 2 ]; then
						update_nodes update &
					else
						fwupd -m 2 &
					fi	
					;;
				"done")
					;; 
				*)
					AUTOFLAG=`utctx_cmd get fwup_autoupdate_flags`
					eval $AUTOFLAG
					if [ "${SYSCFG_fwup_autoupdate_flags}" -ne "0" ]; then
						if [ "$NODES_MODE" != 1 ]; then
							fwupd -e &
						fi
					fi
					;;
			esac
		fi
	fi		
