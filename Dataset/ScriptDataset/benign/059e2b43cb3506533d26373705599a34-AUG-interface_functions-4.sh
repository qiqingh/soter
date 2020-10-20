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
    if [ "`syscfg get hardware_vendor_name`" = "Broadcom" ] ; then
        if [ "$2" != "1" ] ; then
            REPLACEMENT=`syscfg get wan_mac_addr`
        else
            REPLACEMENT=`syscfg get lan_mac_addr`
        fi
    else
        INCR_AMOUNT=`expr $2 - 1`
        OUR_MAC=`get_mac "vlan"$2`
        REPLACEMENT=`incr_mac $OUR_MAC $INCR_AMOUNT`
    fi
    ip link set vlan$2 down
    ip link set vlan$2 addr $REPLACEMENT
    `sysevent set vlan$2_mac $REPLACEMENT`
