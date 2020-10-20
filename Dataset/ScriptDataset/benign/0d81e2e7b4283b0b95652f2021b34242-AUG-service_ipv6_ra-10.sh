   FW_RESTART_REQ=0
   RADVDD_REQ=0
   CURRENT_WAN_STATE=`sysevent get wan-status`
   CURRENT_LAN_STATE=`sysevent get lan-status`
   if [ "stopped" = "$CURRENT_WAN_STATE" ] && [ "stopped" = "$CURRENT_LAN_STATE" ] ; then
      return
   elif [ "stopping" = "$CURRENT_WAN_STATE" ] || [ "starting" = "$CURRENT_WAN_STATE" ] ; then
      return
   elif [ "stopping" = "$CURRENT_LAN_STATE" ] || [ "starting" = "$CURRENT_LAN_STATE" ] ; then
      return
   else
      RADVD_REQ=1
   fi
   if [ "" != "$SYSCFG_StaticRouteCount" ] && [ "0" != "$SYSCFG_StaticRouteCount" ] ; then
      FW_RESTART_REQ=1
   fi
