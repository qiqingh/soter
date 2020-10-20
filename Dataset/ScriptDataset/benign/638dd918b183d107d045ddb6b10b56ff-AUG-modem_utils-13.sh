	FOO=`utctx_cmd get modem::enabled lan_ipaddr lan_netmask modem_lan_ipaddr modem_lan_netmask`
	eval $FOO
	if [ "$SYSCFG_modem_enabled" = "0" ] ; then
		return
	fi
	eval `ipcalc -p 0.0.0.0 $SYSCFG_lan_netmask`
	LAN_PREFIX_LEN=$PREFIX
	eval `ipcalc -p 0.0.0.0 $SYSCFG_modem_lan_netmask`
	MODEM_LAN_PREFIX_LEN=$PREFIX
	is_network_conflict $SYSCFG_lan_ipaddr $LAN_PREFIX_LEN $SYSCFG_modem_lan_ipaddr $MODEM_LAN_PREFIX_LEN
	if [ "$?" != 0 ] ; then
		ulog network_functions status "${SERVICE_NAME}, Conflict detected between Lan Networks and modem IP address. Repairing."
		LAN_FIRST_OCTET=`echo $SYSCFG_lan_ipaddr | cut -d'.' -f1`
		if [ "$LAN_FIRST_OCTET" = "10" ] ; then
			SYSCFG_modem_lan_ipaddr=172.16.0.1
			syscfg set modem_lan_ipaddr 172.16.0.1
			syscfg set modem::ipaddr 172.16.0.2
		else
			SYSCFG_modem_lan_ipaddr=10.0.1.1
			syscfg set modem_lan_ipaddr 10.0.1.1
			syscfg set modem::ipaddr 10.0.1.2
		fi 
		syscfg commit
		configure_modem_ip
	fi
	ifconfig vlan3 $SYSCFG_modem_lan_ipaddr netmask $SYSCFG_modem_lan_netmask
	return 0
