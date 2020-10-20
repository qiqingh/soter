    ret=0
    
	TIME=0
	STATUS_TIMEOUT=12
    
	ENDTIME=`date +%s`
	ENDTIME=`expr $ENDTIME + $STATUS_TIMEOUT`
	
	while [ true ] ; do
    
        
        check_apccli_status=`iwconfig $ifname_cmd | grep ESSID | cut -d '"' -f 2 `
        
        if [ "$check_apccli_status" = "$WIFI_CMD_SSID" ]; then
        
            record_wlanBridge_setting $ifname_cmd
 
            # Skip internet check, let internetcheck.sh for led status
            add_apccli_minotor=`cat /etc/crontabs/root | grep APCLIENT_MONITOR`           
            if [ "$add_apccli_minotor" = "" ]; then  
                echo "*/3 * * * * /bin/apcli_monitor.sh #APCLIENT_MONITOR" >>  /etc/crontabs/root
                /etc/init.d/cron restart    
            fi

            
            
            ret=1
            break
        fi
        
    	TIME=0
		sleep 4

        TIME=`date +%s`
        if [ $TIME -gt $ENDTIME ] ; then
        
            break
        fi	
    done
    return $ret
