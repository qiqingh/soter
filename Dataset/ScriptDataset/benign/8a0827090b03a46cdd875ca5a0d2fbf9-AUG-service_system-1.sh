   SYSCFG_FAILED='false'
   FOO=`utctx_cmd get wan_physical_ifname wan_virtual_ifnum lan_ifname lan_ipaddr last_known_date`
   eval $FOO
   if [ $SYSCFG_FAILED = 'true' ] ; then
      ulog system status "$PID utctx failed to get some configuration data required by service-system"
      ulog system status "$PID THE SYSTEM IS NOT SANE"
      echo "[utopia] utctx failed to get some configuration data required by service-system" > /dev/console
      echo "[utopia] THE SYSTEM IS NOT SANE" > /dev/console
      sysevent set ${SERVICE_NAME}-status error
      sysevent set ${SERVICE_NAME}-errinfo "Unable to get crucial information from syscfg"
      exit
   fi
