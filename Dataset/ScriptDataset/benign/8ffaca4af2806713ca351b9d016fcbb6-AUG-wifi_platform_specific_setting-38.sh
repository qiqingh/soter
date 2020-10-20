	PHY_IF=$1
	ulog wlan status "${SERVICE_NAME}, bring ${PHY_IF} down"
	wl -i ${PHY_IF} ssid "" > /dev/null
	wl -i ${PHY_IF} down
