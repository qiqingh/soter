	VIR_IF=$1
	ulog wlan status "${SERVICE_NAME}, bring $VIR_IF up"
	wl -i ${VIR_IF} bss up
