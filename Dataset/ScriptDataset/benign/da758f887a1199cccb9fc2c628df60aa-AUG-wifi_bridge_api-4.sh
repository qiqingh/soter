    connected=`is_sta_connected`
    if [ "$connected" = "yes" ]; then
	    STA_VIR_IF=`syscfg_get wifi_sta_vir_if`
	    iwconfig $STA_VIR_IF | grep "Access Point:" | awk -F'Access Point:' '{print $2}' | awk '{print $1}'
    else
        echo "xx:xx:xx:xx:xx:xx"
    fi
    
