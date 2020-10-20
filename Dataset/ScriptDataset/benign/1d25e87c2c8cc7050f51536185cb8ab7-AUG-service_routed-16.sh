   SYSCFG_FAILED='false'
   FOO=`utctx_cmd get hostname lan_ifname guest_enabled guest_lan_ifname router_adv_enable dhcpv6s_enable rip_enabled rip_interface_wan rip_interface_lan rip_md5_passwd get rip_text_passwd StaticRouteCount bridge_mode`
   eval $FOO
  if [ $SYSCFG_FAILED = 'true' ] ; then
     ulog routed status "$PID utctx failed to get some configuration data"
     exit
  fi
  if [ -z "$SYSCFG_hostname" ] ; then
      SYSCFG_hostname=`cat /etc/hostname`
  fi
