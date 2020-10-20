	PHY_IF=$1
	ulog wlan status "${SERVICE_NAME}, bring $1 up"
	wl -i ${PHY_IF} up
