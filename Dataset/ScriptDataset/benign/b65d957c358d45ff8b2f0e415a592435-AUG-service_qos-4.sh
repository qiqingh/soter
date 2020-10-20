   disable_port_qos_on_ethernet_switch
    lan_ports=`syscfg get switch::router_1::port_numbers`
    port_switch_id=`syscfg get switch::router_1::port_switch_id`
    j=1
    for i in $port_switch_id; do
        port_no=$(echo $lan_ports | cut -f $j -d ' ')
        if [ -z "$port_switch_id" -o $i = 0 ] ; then
            set_prio_on_ethernet_port $port_no 0
        fi
        j=`expr $j + 1`
    done
    set_prio_on_ethernet_port 5 0
    set_prio_on_ethernet_port 8 0
