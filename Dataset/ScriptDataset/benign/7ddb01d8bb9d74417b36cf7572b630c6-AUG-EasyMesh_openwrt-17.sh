	sleep 3
	echo "WAPP starting..."
	wapp_openwrt.sh > /dev/null
	sleep 3
	echo "BS2.0 Daemon starting..."
	bs20 &
	sleep 3
	disconnect_all_sta
	echo "Stand Alone BS2.0 is ready"
