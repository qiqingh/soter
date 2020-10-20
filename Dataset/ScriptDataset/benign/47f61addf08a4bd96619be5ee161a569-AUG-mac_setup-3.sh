	DEFAULT_SSID=`syscfg get device::default_ssid`
	DEFAULT_PASSPHRASE=`syscfg get device::default_passphrase`
	syscfg set wl0_ssid "$DEFAULT_SSID"
	syscfg set wl0_passphrase "$DEFAULT_PASSPHRASE"
	syscfg set wl1_ssid "${DEFAULT_SSID}_5GHz"
	syscfg set wl1_passphrase "$DEFAULT_PASSPHRASE"
