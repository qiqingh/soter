   for loop in $SYSCFG_lan_ethernet_physical_ifnames
   do
      ip link set $loop down
   done
