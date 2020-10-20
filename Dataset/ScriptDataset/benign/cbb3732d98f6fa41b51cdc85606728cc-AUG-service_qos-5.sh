   if [ -z "$SYSCFG_QoSEthernetPort_1" ] && [ -z "$SYSCFG_QoSEthernetPort_2" ] && [ -z "$SYSCFG_QoSEthernetPort_3" ] && [ -z "$SYSCFG_QoSEthernetPort_4" ] ; then
      disable_ethernet_port_based_qos
      return 0
   fi
   IS_QOS=0
   for loop in 1 2 3 4
   do
      CURRENT_LOOP="SYSCFG_QoSEthernetPort_$loop"
      eval QOS='$'$CURRENT_LOOP
      if [ "\$HIGH" = "$QOS" ] ; then 
         set_prio_on_ethernet_port $loop 14
         IS_QOS=1
      elif [ "\$MEDIUM" = "$QOS" ] ; then                         
         set_prio_on_ethernet_port $loop 10
         IS_QOS=1
      elif [ "\$NORMAL" = "$QOS" ] ; then                         
         set_prio_on_ethernet_port $loop 6
         IS_QOS=1
      elif [ "\$LOW" = "$QOS" ] ; then                         
         set_prio_on_ethernet_port $loop 2
         IS_QOS=1
      else
         set_prio_on_ethernet_port $loop 6
      fi
   done
   set_prio_on_ethernet_port 0 14
   set_prio_on_ethernet_port 5 14
   set_prio_on_ethernet_port 8 14
   if [ "1" = "$IS_QOS" ] ; then
      enable_port_qos_on_ethernet_switch
   fi
