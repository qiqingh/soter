	printf "#############################################igmpproxy config##########################################\n"
	uci show igmpproxy
	cat /etc/config/igmpproxy
	printf "========================================\n"
	cat /var/etc/igmpproxy.conf
	printf "========================================\n"
	cat /proc/net/ip_mr_*
	printf "========================================\n"
	ps | grep igmp
	printf "\n"
