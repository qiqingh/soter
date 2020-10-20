	printf "#############################################rip config##########################################\n"
	cat /etc/quagga/ripd.conf
	printf "========================================\n"
	cat /etc/quagga/zebra.conf
	printf "========================================\n"
	ps | grep rip
	ps | grep zebra
	printf "\n"
