	PHY_IF=$1
	if [ -f /var/run/miniupnpd.$PHY_IF ]; then
		echo "wifi $PHY_IF, stopping wps processes"
		kill `cat /var/run/miniupnpd.$PHY_IF`
		rm -f /var/run/miniupnpd.$PHY_IF
		iwpriv $PHY_IF set WscConfMode=0 1>/dev/null 2>&1
		route delete 239.255.255.250 1>/dev/null 2>&1
	fi
	if [ -f /var/run/wsc_monitor.pid.$PHY_IF ]; then
		kill `cat /var/run/wsc_monitor.pid.$PHY_IF`
		rm -f /var/run/wsc_monitor.pid.$PHY_IF
	fi
