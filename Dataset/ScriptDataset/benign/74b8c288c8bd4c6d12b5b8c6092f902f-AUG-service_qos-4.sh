   disable_port_qos_on_ethernet_switch
   for loop in 1 2 3 4
   do
      set_prio_on_ethernet_port $loop 0
   done
    set_prio_on_ethernet_port 0 0
    set_prio_on_ethernet_port 5 0
    set_prio_on_ethernet_port 8 0
