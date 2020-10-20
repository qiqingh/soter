    ip link set $1 up
    vconfig set_name_type VLAN_PLUS_VID_NO_PAD
    if [ ! -e /proc/net/vlan/vlan$2 ] ; then
        vconfig add $1 $2
    fi
    vconfig set_ingress_map vlan$2 0 0
    vconfig set_ingress_map vlan$2 1 1
    vconfig set_ingress_map vlan$2 2 2
    vconfig set_ingress_map vlan$2 3 3
    vconfig set_ingress_map vlan$2 4 4
    vconfig set_ingress_map vlan$2 5 5
    vconfig set_ingress_map vlan$2 6 6
    vconfig set_ingress_map vlan$2 7 7
    ip link set vlan$2 mtu 1500
    ip link set vlan$2 up
    if [ "$2" != "1" ] ; then
        REPLACEMENT=`syscfg get wan_mac_addr`
    else
        REPLACEMENT=`syscfg get lan_mac_addr`
    fi
    ip link set vlan$2 down
    ip link set vlan$2 addr $REPLACEMENT
    `sysevent set vlan$2_mac $REPLACEMENT`
    if [ "`syscfg get modem::enabled`" = "1" ] ; then	
        if [ "`syscfg get switch::router_3::port_numbers`" = "4" ] ; then
            et -i eth0 robowr 0x34 0x18 0x0003 2
        elif [ "`syscfg get switch::router_3::port_numbers`" = "0" ] ; then
            et -i eth0 robowr 0x34 0x10 0x0003 2
        fi
    fi
