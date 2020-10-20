   FOO=`utctx_cmd get lan_ifname hostname dhcpc_trusted_dhcp_server hardware_vendor_name bridge_mode`
   eval $FOO
  if [ -n "$SYSCFG_dhcpc_trusted_dhcp_server" ]
  then
     DHCPC_EXTRA_PARAMS="-X $SYSCFG_dhcpc_trusted_dhcp_server"
  fi
  if [ -z "$SYSCFG_hostname" ] ; then
     SYSCFG_hostname="Utopia"
  fi
