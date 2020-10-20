	TIME=0
	STATUS_TIMEOUT=20
    
    
    
	ENDTIME=`date +%s`
	ENDTIME=`expr $ENDTIME + $STATUS_TIMEOUT`
	
	while [ true ] ; do
    
        
        check_apccli_status=`iwconfig $ifname_cmd | grep ESSID | cut -d '"' -f 2 `

        if [ "$check_apccli_status" != "" ]; then
        
            check_wsc_status=`ps | grep wsc_monitor | grep D | grep -v grep`
            [ "$check_wsc_status" = "" ] && wps_action.sh start
            break
            
        fi
        
    	TIME=0
		sleep 4

        TIME=`date +%s`
        if [ $TIME -gt $ENDTIME ] ; then
        
            #log "apcli_monitor_status FAIL" 
            #iwpriv $ifname_cmd set ApCliEnable=1

            killall wsc_monitor
            sleep 1
            
            [ ! -f "$RUNNING" ] && iwpriv $ifname_cmd set ApCliAutoConnect=1

            #/usr/bin/ledstatus.sh internet_connect_fail
            break
        fi	
    done

