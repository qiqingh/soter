    if [ "$wps_enable" = "1" ] ; then
        #2g
        [ "$onoff_2g" = "1" -a "$hiddenAP_2g" = "0" ] && {
            wsc_monitor -i ra0 -D
        }
        #5g    
        [ "$onoff_5g" = "1" -a "$hiddenAP_5g" = "0" ] && {
            wsc_monitor -i rai0 -D
        }
    fi
