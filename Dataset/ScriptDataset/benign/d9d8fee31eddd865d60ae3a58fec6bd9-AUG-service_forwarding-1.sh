   echo 2 > /proc/sys/net/ipv4/conf/all/arp_ignore
   SYSCFG_FAILED='false'
   FOO=`utctx_cmd get bridge_mode ldal_wl_lego_device_type lan_ifname`
   eval $FOO
   if [ $SYSCFG_FAILED = 'true' ] ; then
      ulog forwarding status "$PID utctx failed to get some configuration data required by service-forwarding"
      ulog forwarding status "$PID THE SYSTEM IS NOT SANE"
      echo "[utopia] utctx failed to get some configuration data required by service-system" > /dev/console
      echo "[utopia] THE SYSTEM IS NOT SANE" > /dev/console
      sysevent set ${SERVICE_NAME}-status error
      sysevent set ${SERVICE_NAME}-errinfo "Unable to get crucial information from syscfg"
      exit
   fi
