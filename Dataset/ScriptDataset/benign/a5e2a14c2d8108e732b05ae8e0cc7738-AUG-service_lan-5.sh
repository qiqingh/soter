   if [ "Broadcom" != $SYSCFG_hardware_vendor_name ] ; then		
       return 
   fi
   INCR_AMOUNT=10
   if [ "" != "$SYSCFG_lan_wl_physical_ifnames" ] ; then
       for loop in $SYSCFG_lan_wl_physical_ifnames
       do
           OUR_MAC=`get_mac "eth0"`
           REPLACEMENT=`incr_mac $OUR_MAC $INCR_AMOUNT`
           ip link set $loop addr $REPLACEMENT
           ip link set $loop allmulticast on
           ulog lan status "setting $loop hw address to $REPLACEMENT"
           INCR_AMOUNT=`expr $INCR_AMOUNT + 1`
           if [ "eth1" = $loop ] ; then
               WL_STATE=`syscfg get wl0_state`
           else
               WL_STATE=`syscfg get wl1_state`
           fi
           ulog lan status "wlancfg $loop $WL_STATE"
           wlancfg $loop $WL_STATE
           enslave_a_interface $loop $SYSCFG_lan_ifname
      done
   fi
   bringup_wireless_daemons
