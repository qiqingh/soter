    register_dhcp_client_handlers
    asyncid=`sysevent async phylink_wan_state /etc/init.d/service_bridge/dhcp_link.sh`
    sysevent set phylink_wan_state_asyncid "$asyncid"
