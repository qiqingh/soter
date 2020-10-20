	killall -9 rdt
	rm /etc/nvram -rf
	echo auto_reboot=0 >/etc/nvram
	echo keep_run=0 >>/etc/nvram
	rdt
