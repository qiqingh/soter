	rm -rf /tmp/wapp_ctrl
	killall -15 mapd
	killall -15 wapp
	killall -15 p1905_managerd
	killall -15 bs20
	echo -e "----- ${RED}killed all apps ${NC} -----"
