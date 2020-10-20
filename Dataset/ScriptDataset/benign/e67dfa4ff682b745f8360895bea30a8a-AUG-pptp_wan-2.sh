   IFNAME=`sysevent get ${NAMESPACE}_current_wan_ifname`
   unregister_firewall_hooks
   NAME=`sysevent setunique GeneralPurposeFirewallRule " -A INPUT -i $IFNAME -s $SYSCFG_wan_proto_server_address -p tcp -m tcp --sport 1723 -j xlog_accept_wan2self"`
   sysevent set ${SELF_NAME}_gp_fw_1 "$NAME"
   NAME=`sysevent setunique GeneralPurposeFirewallRule " -A INPUT -i $IFNAME -s $SYSCFG_wan_proto_server_address -p udp -m udp --sport 1723 -j xlog_accept_wan2self"`
   sysevent set ${SELF_NAME}_gp_fw_2 "$NAME"
   NAME=`sysevent setunique GeneralPurposeFirewallRule " -A INPUT -i $IFNAME -s $SYSCFG_wan_proto_server_address -p 0x2f -j xlog_accept_wan2self"`
   sysevent set ${SELF_NAME}_gp_fw_3 "$NAME"
   NAME=`sysevent setunique NatFirewallRule " -A PREROUTING -i $IFNAME -s $SYSCFG_wan_proto_server_address -p tcp -m tcp --sport 1723 -j RETURN"`
   sysevent set ${SELF_NAME}_nat_fw_1 "$NAME"
   NAME=`sysevent setunique NatFirewallRule " -A PREROUTING -i $IFNAME -s $SYSCFG_wan_proto_server_address -p udp -m udp --sport 1723 -j RETURN"`
   sysevent set ${SELF_NAME}_nat_fw_2 "$NAME"
   NAME=`sysevent setunique NatFirewallRule " -A PREROUTING -i $IFNAME -s $SYSCFG_wan_proto_server_address -p 0x2f -j RETURN"`
   sysevent set ${SELF_NAME}_nat_fw_3 "$NAME"
   sysevent set firewall-restart
