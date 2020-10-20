	PHY_IF=$1
	set_driver_mac_filter_enabled $PHY_IF
	configure_guest $PHY_IF
