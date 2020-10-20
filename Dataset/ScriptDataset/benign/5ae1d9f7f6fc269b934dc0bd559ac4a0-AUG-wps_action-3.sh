    log_info "wps" "wps_monitor_status"

    local wps_ledstatus=

	TIME=0
	STATUS_TIMEOUT=120

	ENDTIME=`date +%s`
	ENDTIME=`expr $ENDTIME + $STATUS_TIMEOUT`

	while [ true ] ; do

        wps_status_5g=`wsc_monitor -i rai0`
        wps_status_24g=`wsc_monitor -i ra0`

		if [ $wps_status_5g = 34 ] ; then
            
			record_security_setting rai0
            log_info "wps" "5G Connected!"
            /usr/bin/ledstatus.sh wps_finish
			return 0
    	fi

		if [ $wps_status_24g = 34  ] ; then
            
			record_security_setting ra0
            log_info "wps" "2.4G Connected!"
            /usr/bin/ledstatus.sh wps_finish
			return 0
    	fi

        if [ $wps_status_5g = 2 ] || [ $wps_status_5g = 31 ] || [ $wps_status_5g = 32 ] || [ $wps_status_5g = 33 ] ; then
            iwpriv rai0 set WscStop=1
            /usr/bin/ledstatus.sh wps_fail
        fi

        if [ $wps_status_24g = 2 ] || [ $wps_status_24g = 31 ] || [ $wps_status_24g = 32 ] || [ $wps_status_24g = 33 ] ; then
            iwpriv ra0 set WscStop=1
            /usr/bin/ledstatus.sh wps_fail
        fi

		TIME=0
		sleep 1

        TIME=`date +%s`
        if [ $TIME -gt $ENDTIME ] ; then

            iwpriv rai0 set WscStop=1
            iwpriv ra0 set WscStop=1
            /usr/bin/ledstatus.sh wps_fail
            sleep 60 && /usr/bin/ledstatus.sh wps_finish  &
            break
        fi
	done



