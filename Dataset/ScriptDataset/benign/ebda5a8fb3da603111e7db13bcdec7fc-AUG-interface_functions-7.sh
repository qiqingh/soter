    if [ "1" = "`sysevent get emf_started`" ] ; then
        return
    fi
    MODEL_NAME=`syscfg get device::model_base`
    if [ -z "$MODEL_NAME" ] ; then
        MODEL_NAME=`syscfg get device::modelNumber`
    fi
    if [ "$MODEL_NAME" = "EA6200" -o "$MODEL_NAME" = "EA6350" -o "$MODEL_NAME" = "EA6400" -o "$MODEL_NAME" = "EA6500" -o "$MODEL_NAME" = "EA6700" -o "$MODEL_NAME" = "EA6900" ]; then
        sleep 3
        echo "configuring interfaces for IGMP filtering" >> /dev/console
        emf add bridge br0
        igs add bridge br0
        emf add iface br0 vlan1
        emf add iface br0 eth1
        emf add iface br0 eth2
        sysevent set emf_started 1
    fi
