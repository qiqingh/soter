    ret=0
    
	TIME=0
	STATUS_TIMEOUT=8
    
	ENDTIME=`date +%s`
	ENDTIME=`expr $ENDTIME + $STATUS_TIMEOUT`
	
	while [ true ] ; do
    
        
        check_apccli_status=`iwconfig $ifname_cmd | grep ESSID | cut -d '"' -f 2 `
        
        if [ "$check_apccli_status" = "$WIFI_CMD_SSID" ]; then
        
            ret=1
            break
        fi
        
    	TIME=0
        TIME=`date +%s`
        if [ $TIME -gt $ENDTIME ] ; then
        
            break
        fi	
        
        sleep 1
        
    done
    return $ret
