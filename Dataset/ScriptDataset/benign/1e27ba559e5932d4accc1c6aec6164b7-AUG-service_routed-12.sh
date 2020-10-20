   FW_RESTART_REQ=0
   ROUTED_REQ=0
   RIPD_REQ=0
   CURRENT_WAN_STATE=`sysevent get wan-status`
   CURRENT_LAN_STATE=`sysevent get lan-status`
   if [ "stopped" = "$CURRENT_WAN_STATE" ] && [ "stopped" = "$CURRENT_LAN_STATE" ] ; then
      return
   elif [ "stopping" = "$CURRENT_WAN_STATE" ] ; then
      return
   elif [ "stopping" = "$CURRENT_LAN_STATE" ] || [ "starting" = "$CURRENT_LAN_STATE" ] ; then
      return
   else
      ROUTED_REQ=1
   fi
   if [ "1" = "$SYSCFG_rip_enabled" ] ; then
      RIPD_REQ=1
      FW_RESTART_REQ=1
   fi
   if [ "" != "$SYSCFG_StaticRouteCount" ] && [ "0" != "$SYSCFG_StaticRouteCount" ] ; then
      FW_RESTART_REQ=1
   fi
