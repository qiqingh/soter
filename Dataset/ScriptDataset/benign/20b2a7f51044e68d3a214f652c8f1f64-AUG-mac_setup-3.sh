	# LAN MAC
	LAN_MAC=$ETH0_MAC

	# WAN MAC
	WAN_MAC=$ETH0_MAC

	#2.4G MAC address = WAN_MAC + 1
	W24G_MAC=`apply_mac_inc -m "$WAN_MAC" -i 1`

	# 5G MAC address = WAN_MAC + 2
	W5G_MAC=`apply_mac_inc -m "$WAN_MAC" -i 2`

	# Guest MAC = WAN_MAC + 3 (first byte is admin byte)
	GUEST_MAC=`apply_mac_inc -m "$WAN_MAC" -i 3`
	GUEST_MAC=`apply_mac_adbit -m "$GUEST_MAC"`

	# SimpleTap MAC = WAN_MAC + 4 (first byte is admin byte)
	TC_MAC=`apply_mac_inc -m "$WAN_MAC" -i 4`
	TC_MAC=`apply_mac_adbit -m "$TC_MAC"`

	# convert to upper case
	LAN_MAC=`echo $LAN_MAC | tr '[a-z]' '[A-Z]'`
	WAN_MAC=`echo $WAN_MAC | tr '[a-z]' '[A-Z]'`
	W24G_MAC=`echo $W24G_MAC | tr '[a-z]' '[A-Z]'`
	W5G_MAC=`echo $W5G_MAC | tr '[a-z]' '[A-Z]'`
	GUEST_MAC=`echo $GUEST_MAC | tr '[a-z]' '[A-Z]'`
	TC_MAC=`echo $TC_MAC | tr '[a-z]' '[A-Z]'`

	# This is common for all platforms
	syscfg_set lan_mac_addr $LAN_MAC
	syscfg_set wan_mac_addr $WAN_MAC
	syscfg_set wl0_mac_addr $W24G_MAC
	syscfg_set wl1_mac_addr $W5G_MAC
	syscfg_set wl0.1_mac_addr $GUEST_MAC
	syscfg_set wl0.2_mac_addr $TC_MAC
	return 0
