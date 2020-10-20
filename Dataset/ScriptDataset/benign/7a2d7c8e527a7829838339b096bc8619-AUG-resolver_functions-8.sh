    if [ "`syscfg get hardware_vendor_name`" = "Broadcom" ] ; then
        is_platform_pinnacles
        IS_PINNACLES=$?
        lan_ports=`syscfg get switch::router_1::port_numbers`
        if [ "$IS_PINNACLES" = "1" ] ; then       
            if [ -n "$lan_ports" ] ; then
                echo "Power cycle Ethernet ports." > /dev/console
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
                echo "Power cycle Ethernet ports." > /dev/console
                for i in $lan_ports; do
                    et phywr $i 0 0x1940
                done
                sleep 1.5
                for i in $lan_ports; do
                    et phywr $i 0 0x1140
                done
            fi
        fi
    elif [ "`syscfg get hardware_vendor_name`" = "Marvell" ] ; then
        if [ -d /sys/devices/platform/mv_switch ] ; then
            lan_ports=`syscfg get switch::router_1::port_numbers`
            if [ -n "$lan_ports" ] ; then
                echo "Power cycle Ethernet ports." > /dev/console
                for i in $lan_ports; do
                    echo $i 0 1 0x1940 > /sys/devices/platform/mv_switch/reg_w
                done
                sleep 1.5
                for i in $lan_ports; do
                    echo $i 0 1 0x1140 > /sys/devices/platform/mv_switch/reg_w
                done
            fi
        else
            if [ -d /sys/class/neta-switch/port0/power ] ; then
                lan_ports=/sys/class/neta-switch/port[0123]/power_config
            else
                lan_ports=/sys/class/neta-switch/port[0123]/power
            fi
        
            if [ -n "$lan_ports" ] ; then
                echo "Power cycle Ethernet ports." > /dev/console
	            for i in $lan_ports; do
	                echo 0 > $i
	            done
	            sleep 1.5
	            for i in $lan_ports; do
	                echo 1 > $i
	            done
            fi
        fi
    elif [ "`syscfg get hardware_vendor_name`" = "MediaTek" ] ; then
        product=`cat /etc/product`
        if [ "$product" = "taurus" ] ; then
            echo "Power cycle Ethernet ports." > /dev/console
            for i in 0 1 2 3 ; do
                mii_mgr -s -p $i -r 0 -v 0x3900 > /dev/null
            done
            sleep 1.5
            for i in 0 1 2 3 ; do
                mii_mgr -s -p $i -r 0 -v 0x3100 > /dev/null
            done
        elif [ "$product" = "atlanta" -o "$product" = "augusta" -o "$product" = "savannah" -o "$product" = "athens" -o "$product" = "cocoon" -o "$product" = "austin" -o "$product" = "waldorf" ] ; then
            echo "Power cycle Ethernet ports." > /dev/console
            for i in 1 2 3 4; do
                mii_mgr -s -p $i -r 0 -v 0x3900 > /dev/null
            done
            sleep 1.5
            for i in 1 2 3 4; do
                mii_mgr -s -p $i -r 0 -v 0x3100 > /dev/null
            done
            if [ "$product" = "austin" ] ; then
		mii_mgr -s -p 0 -r 13 -v 0x1f
		mii_mgr -s -p 0 -r 14 -v 0x24
		mii_mgr -s -p 0 -r 13 -v 0x401f
		mii_mgr -s -p 0 -r 14 -v 0xc000
	    fi	
        else
            echo "Power cycle Ethernet ports." > /dev/console
            switch reg w 7014 1e0000c
            switch reg w 7014 2e0000c
            switch reg w 7014 3e0000c
            switch reg w 7014 4e0000c
            sleep 1.5
            switch reg w 7014 e0000c
        fi
    elif [ "`syscfg get hardware_vendor_name`" = "QCA" ] ; then
        echo "Power cycle Ethernet ports." > /dev/console
        if [ "`cat /etc/product`" = "wraith" ] ; then
            lan_ports="0 1 2 3"
        elif [ "`cat /etc/product`" = "macan" ] ; then
            lan_ports="1 2 3 4"
        fi
        for i in $lan_ports; do
            ssdk_sh debug phy set $i 0 0x1800 > /dev/null 2>&1
        done
        sleep 1.5
        for i in $lan_ports; do
            ssdk_sh debug phy set $i 0 0x1000 > /dev/null 2>&1
        done
    fi
