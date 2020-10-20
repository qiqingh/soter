    echo "Power cycle Ethernet ports." > /dev/console
    if [ "`syscfg get hardware_vendor_name`" = "Broadcom" ] ; then
        is_platform_pinnacles
        IS_PINNACLES=$?
        lan_ports=`syscfg get switch::router_1::port_numbers`
        if [ "$IS_PINNACLES" = "1" ] ; then       
            if [ -n "$lan_ports" ] ; then
                for i in $lan_ports; do
                    et -i eth0 robowr 0x1$i 0x00 0x1940
                done
                sleep 1.5
                for i in $lan_ports; do
                    et -i eth0 robowr 0x1$i 0x00 0x1140
                done
            fi
        else
            if [ -n "$lan_ports" ] ; then
                for i in $lan_ports; do
                    et phywr $i 0 0x1940
                done
                sleep 1.5
                for i in $lan_ports; do
                    et phywr $i 0 0x1140
                done
            fi
        fi
    elif [ -d /sys/class/neta-switch ] ; then
            if [ -d /sys/class/neta-switch/port0/power ] ; then
                echo "reset LAN ethernet port"
                lan_ports=/sys/class/neta-switch/port[0123]/power_config
            else
                lan_ports=/sys/class/neta-switch/port[0123]/power
            fi
        
            if [ -n "$lan_ports" ] ; then
	            for i in $lan_ports; do
	                echo 0 > $i
	            done
	            sleep 1.5
	            for i in $lan_ports; do
	                echo 1 > $i
	            done
            fi
    elif [ "`syscfg get hardware_vendor_name`" = "MediaTek" ] ; then
        switch reg w 7014 1e0000c
        switch reg w 7014 2e0000c
        switch reg w 7014 3e0000c
        switch reg w 7014 4e0000c
        sleep 1.5
        switch reg w 7014 e0000c
    fi
