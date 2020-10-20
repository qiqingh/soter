	printf "#############################################check firmware##########################################\n"
	cat /etc/version
	cat /proc/version
	printf "===================checkfw=====================\n"
	[ -f "/tmp/checkfw" ] && { cat /tmp/checkfw ; }
	printf "===================fwstatus=====================\n"
	[ -f "/tmp/fwstatus" ] && { cat /tmp/fwstatus ; }
	printf "===================fwperc=====================\n"
	[ -f "/tmp/fwperc" ] && { cat /tmp/fwperc ; }
	printf "========================================\n"
	ls /tmp/*.img
	printf "\n"
