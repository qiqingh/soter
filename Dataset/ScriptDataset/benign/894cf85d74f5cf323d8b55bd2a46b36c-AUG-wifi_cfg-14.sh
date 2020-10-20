	PHY_IF=$1
	wifi_band=2
	if [ "rai0" = "$PHY_IF" ]; then
		wifi_band=5
	fi
	config_file=$CONFIG_FILE_2G
	if [ "5" = "$wifi_band" ]; then
		config_file=$CONFIG_FILE_5G
	fi
	if [ "2" = "$wifi_band" ]; then
		create_2g_cfg
	fi
	if [ "5" = "$wifi_band" ]; then
		create_5g_cfg
	fi
