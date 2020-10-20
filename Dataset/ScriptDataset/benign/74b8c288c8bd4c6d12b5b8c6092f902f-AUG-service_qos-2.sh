   if [ "started" = "$LAN_STATUS" ] ; then
      for loop in br0
      do
         prepare_wan_shaping $loop
         ulog qos status "Enable Wan Shaping on $loop"
      done
        for loop in $LAN_IFNAMES
        do
           prepare_lan_qos_queue_disciplines $loop
           ulog qos status "Enable QoS on $loop"
        done
        for loop in ${SYSCFG_wl0_user_vap} ${SYSCFG_wl1_user_vap} ${SYSCFG_wl0_guest_vap}
        do
           prepare_wireless_lan_qos_queue_disciplines $loop
           ulog qos status "Enable QoS on $loop"
        done
      conntrack -F > /dev/null 2>&1
   fi
