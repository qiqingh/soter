	UPTIME=`cat /proc/uptime | cut -d'.' -f1`
	BASETIME="60"
	if [ $UPTIME -lt $BASETIME ]; then
		return 0
	fi
	AUTOFLAG=`utctx_cmd get fwup_autoupdate_flags`
	eval $AUTOFLAG
	if [ "${SYSCFG_fwup_autoupdate_flags}" -ne "2" ]; then
		CHECK_AFTER_BOOT=`sysevent get fwup_checked_after_boot`
		if [ "${CHECK_AFTER_BOOT}" = "0" ]; then
			sysevent set fwup_checked_after_boot 1
		fi
		FORCED_CHECK=`sysevent get fwup_forced_check`
		if [ "${FORCED_CHECK}" -ne "0" ]; then
			sysevent set fwup_forced_check 0
		fi
		return 0
	fi
	
	pidof fwupd > /dev/null
	if [ $? != "0" ] 
	then
		CHECK_AFTER_BOOT=`sysevent get fwup_checked_after_boot`
		if [ "${CHECK_AFTER_BOOT}" = "0" ]; then
			sysevent set fwup_forced_check 1
			fwupd -m 3 &
		else
			FORCED_CHECK=`sysevent get fwup_forced_check`
			CONFIG_FILE="/tmp/update.conf"
			if [ "${FORCED_CHECK}" = "1" ]; then
				if [ -e ${CONFIG_FILE} ]; then
					FORCED_UPDATE=`cat ${CONFIG_FILE} | grep "forced_firmware_update" | cut -d'=' -f2`
					if [ "${FORCED_UPDATE}" = "1" ]; then
						FORCED_UPDATE_DELAY=`cat ${CONFIG_FILE} | grep "forced_update_delay" | cut -d'=' -f2`
						if [ -z  ${FORCED_UPDATE_DELAY} ]; then
							FORCED_UPDATE_DELAY="1"
						fi
						sysevent set fwup_forced_update_delay ${FORCED_UPDATE_DELAY}
						
						FORCED_UPDATE_SIGNAL=`cat ${CONFIG_FILE} | grep "forced_update_signal" | cut -d'=' -f2`
						if [ -z  ${FORCED_UPDATE_SIGNAL} ]; then
							FORCED_UPDATE_SIGNAL="0"
						fi
						sysevent set fwup_forced_update_signal ${FORCED_UPDATE_SIGNAL}
						sysevent set fwup_forced_check 2
					else
						sysevent set fwup_forced_check 0
					fi
					
					rm -f ${CONFIG_FILE}
				else
					sysevent set fwup_forced_check 0
				fi
			elif [ "${FORCED_CHECK}" = "2" ]; then
				FORCED_UPDATE_DELAY=`sysevent get fwup_forced_update_delay`
				FORCED_UPDATE_DELAY_SEC=`expr $FORCED_UPDATE_DELAY \* 60`
				if [ $UPTIME -gt $FORCED_UPDATE_DELAY_SEC ]; then
					fwupd -m 4 -e &
				fi
			elif [ "${FORCED_CHECK}" = "3" ]; then
				fwupd -m 4 -e &
			else
				FORCED_UPDATE_DONE=`sysevent get fwup_forced_update_done`
				if [ "${FORCED_UPDATE_DONE}" = "1" ]; then
					if [ -e "/etc/led/sw_blink.sh" ]; then
						/etc/led/sw_blink.sh 1 > /dev/null
					fi
				else
					AUTOFLAG=`utctx_cmd get fwup_autoupdate_flags`
					eval $AUTOFLAG
					if [ "${SYSCFG_fwup_autoupdate_flags}" -ne "0" ]; then
						fwupd -e &
					fi
				fi
			fi
		fi
	fi		
