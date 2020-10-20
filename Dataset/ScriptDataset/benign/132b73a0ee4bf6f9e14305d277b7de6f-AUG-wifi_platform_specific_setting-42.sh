	PHY_IF=$1
	VIR_IF=$2
	
	ulog wlan status "${SERVICE_NAME}, bring $PHY_IF:$VIR_IF up"
	wl -i ${PHY_IF} bss -C ${VIR_IF} up
