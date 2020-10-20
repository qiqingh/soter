	printf "#############################################upnp config##########################################\n"
	cat /var/etc/miniupnpd-ra0.conf
	printf "========================================\n"
	cat /var/etc/miniupnpd-rai0.conf
	printf "========================================\n"
	ps | grep miniupnp
	cat /var/run/miniupnpd.*
	printf "\n"
