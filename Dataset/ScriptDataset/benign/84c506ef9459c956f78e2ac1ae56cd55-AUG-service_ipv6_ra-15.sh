   SYSCFG_FAILED='false'
   FOO=`utctx_cmd get hostname lan_ifname guest_enabled guest_lan_ifname router_adv_enable dhcpv6s_enable StaticRouteCount dhcp_server_propagate_wan_nameserver 6rd_enable ula_enable wan_proto wan_mtu ipv6_static_enable ipv6_ready`
   eval $FOO
  if [ $SYSCFG_FAILED = 'true' ] ; then
     ulog $SERVICE_NAME status "$PID utctx failed to get some configuration data"
     exit
  fi
  if [ -z "$SYSCFG_hostname" ] ; then
      SYSCFG_hostname=`cat /etc/hostname`
  fi
