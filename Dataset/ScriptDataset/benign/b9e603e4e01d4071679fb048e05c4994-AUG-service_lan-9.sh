   SYSCFG_FAILED='false'
   FOO=`utctx_cmd get lan_ifname lan_ethernet_virtual_ifnums lan_ethernet_physical_ifnames lan_wl_physical_ifnames lan_wl_virtual_ifnames lan_ipaddr lan_netmask hardware_vendor_name bridge_mode`
   eval $FOO
  if [ $SYSCFG_FAILED = 'true' ] ; then
     ulog lan status "$PID utctx failed to get some configuration data"
     ulog lan status "$PID LAN CANNOT BE CONTROLLED"
     exit
  fi
   if [ "" = "$SYSCFG_lan_ethernet_virtual_ifnums" ] ; then
      LAN_IFNAMES="$SYSCFG_lan_ethernet_physical_ifnames"
   else
       for loop in $SYSCFG_lan_ethernet_physical_ifnames
       do
         LAN_IFNAMES="$LAN_IFNAMES vlan$SYSCFG_lan_ethernet_virtual_ifnums"
       done
   fi
