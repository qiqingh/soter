    if [ "`syscfg get hardware_vendor_name`" != "Broadcom" -o "1" = "`sysevent get emf_started`" ] ; then
        return
    fi
    sleep 3
    echo "configuring interfaces for IGMP filtering" >> /dev/console
    emf add bridge br0
    igs add bridge br0
    emf add iface br0 vlan1
    emf add iface br0 eth1
    emf add iface br0 eth2
    sysevent set emf_started 1
