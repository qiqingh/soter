   if [ "" = "$SYSCFG_lan_ethernet_virtual_ifnums" ] ; then
      for loop in $SYSCFG_lan_ethernet_physical_ifnames
      do
          is_intf_used_for_nfsboot $loop
          nfs=$?
          if [ $nfs != "0" ] ; then
             ip link set $loop down
          fi
      done
   else
      if [ "Broadcom" = $SYSCFG_hardware_vendor_name ] ; then
          for loop in $SYSCFG_lan_ethernet_virtual_ifnums
          do
              is_intf_used_for_nfsboot "vlan${loop}"
              nfs=$?
              if [ $nfs != "0" ] ; then
                 ip link set vlan${loop} down
              fi
          done
      else
          for loop in $SYSCFG_lan_ethernet_virtual_ifnums
          do
              unconfig_vlan $loop
          done
      fi
   fi
