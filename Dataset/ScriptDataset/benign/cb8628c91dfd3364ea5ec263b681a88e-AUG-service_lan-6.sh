   if [ "Broadcom" != $SYSCFG_hardware_vendor_name ] ; then		
       return 
   fi
   for loop in $SYSCFG_lan_wl_physical_ifnames
   do
   if [ "Broadcom" = "$SYSCFG_hardware_vendor_name" ] ; then
	  STR=`brctl show | grep $loop`
	  if [ ! -z "$STR" ]; then
	  	brctl delif $SYSCFG_lan_ifname $loop
	  fi
	  ifconfig $loop down
   else
	  wlancfg $loop down
   fi
   done
