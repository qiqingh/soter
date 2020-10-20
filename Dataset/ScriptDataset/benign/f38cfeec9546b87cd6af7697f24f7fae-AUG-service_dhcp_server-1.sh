    FOO=`utctx_cmd get lan_ipaddr lan_netmask bridge_ipaddr bridge_netmask dhcp_server_enabled bridge_mode`
    eval $FOO
    if [ -z "$SYSCFG_lan_ipaddr" ] ; then
       ulog dhcp_server status "Lan is not configured. Using Bridge"
       SYSCFG_lan_ipaddr=$SYSCFG_bridge_ipaddr
       SYSCFG_lan_netmask=$SYSCFG_bridge_netmask
    fi
    if [ -z "$SYSCFG_lan_ipaddr" ] ; then
       ulog dhcp_server status "Lan is not configured. Neither is Bridge. Cannot start dhcp server"
       sysevent set ${SERVICE_NAME}-errinfo "Bad Configuration"
       sysevent set ${SERVICE_NAME}-status Stopped
       exit 0
   fi
