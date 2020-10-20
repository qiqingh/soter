   WL0_ENABLED=`syscfg get wl0_state`
   WL1_ENABLED=`syscfg get wl1_state`
   if [ "up" = "$WL0_ENABLED" ] || [ "up" = "$WL1_ENABLED" ] ; then
       ulog lan status "bringing up wireless eapd daemon"
       eapd
       ulog lan status "bringing up wireless nas daemon"
       nas 
       ulog lan status "bringing up wireless wps monitor"
       wps_monitor &
   fi
