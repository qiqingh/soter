	echo 1 > /etc/rdt_flag
	rm /etc/nvram -rf
	echo auto_reboot=1 >/etc/nvram
	echo keep_run=0 >>/etc/nvram
	rdt -x &
