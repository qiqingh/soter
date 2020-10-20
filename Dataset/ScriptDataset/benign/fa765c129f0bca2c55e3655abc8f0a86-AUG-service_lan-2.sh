   if [ "" != "$SYSCFG_lan_ethernet_virtual_ifnums" ] ; then
       for loop in $SYSCFG_lan_ethernet_physical_ifnames
       do
         config_vlan $loop $SYSCFG_lan_ethernet_virtual_ifnums
       done
   fi
