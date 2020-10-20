	DEFAULT_SSID=`syscfg get device::default_ssid`
	DEFAULT_PASSPHRASE=`syscfg get device::default_passphrase`
	syscfg_set wl0_ssid "$DEFAULT_SSID"
	syscfg_set wl0_passphrase "$DEFAULT_PASSPHRASE"
	syscfg_set wl1_ssid "${DEFAULT_SSID}_5GHz"
	# For test only, will remove this when band steering done.
	syscfg_set wl2_ssid "${DEFAULT_SSID}_5GHz"
	syscfg_set wl1_passphrase "$DEFAULT_PASSPHRASE"
	syscfg_set wl2_passphrase "$DEFAULT_PASSPHRASE"
