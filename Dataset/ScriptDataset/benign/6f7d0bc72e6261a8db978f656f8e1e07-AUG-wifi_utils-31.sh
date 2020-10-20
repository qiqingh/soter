	PHY_IF=$1
	if [ -f /var/run/miniupnpd.$PHY_IF ]; then
		echo "wifi $PHY_IF, stopping wscd"
		kill `cat /var/run/miniupnpd.$PHY_IF`
		rm -f /var/run/miniupnpd.$PHY_IF
	fi
	if [ -f /var/run/wsc_monitor.pid.$PHY_IF ]; then
		kill `cat /var/run/wsc_monitor.pid.$PHY_IF`
		rm -f /var/run/wsc_monitor.pid.$PHY_IF
	fi
