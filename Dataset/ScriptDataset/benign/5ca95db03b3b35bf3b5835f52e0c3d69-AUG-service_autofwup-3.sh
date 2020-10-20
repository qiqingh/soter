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
			sysevent set fwup_forced_check 0
			fwupd -m 3 
			FORCED_UPDATE=`sysevent get fwup_forced_update`
			Debug "fwup_forced_update:" $FORCED_UPDATE
			if [ "$FORCED_UPDATE" != "0" ]; then
				check_dual_partition_update
		
				if [ "$PartitionUpdated" != "2" ]; then
					FORCED_UPDATE_DELAY=`expr 4`
					sleep $FORCED_UPDATE_DELAY
					syscfg set fwup_firmware_version 1
					fwupd -m 4 &
				else
					sysevent set fwupd-success 2
				fi
				sysevent set fwup_forced_check "done"
			fi
		else
			FORCED_CHECK=`sysevent get fwup_forced_check`
			case "${FORCED_CHECK}" in
			"3")
				fwupd -m 4 -e &
				;;
			"done")
				;; 
			*)
				AUTOFLAG=`utctx_cmd get fwup_autoupdate_flags`
				eval $AUTOFLAG
				if [ "${SYSCFG_fwup_autoupdate_flags}" -ne "0" ]; then
					fwupd -e &
				fi
				;;
			esac
		fi
	fi		
