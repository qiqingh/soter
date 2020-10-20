	PHY_IF=$1
	E2pAccessMode=`syscfg_get E2pAccessMode`
	if [ -z "$E2pAccessMode" ]; then
		E2pAccessMode=2
	fi
	
	set_wifi_val $PHY_IF E2pAccessMode $E2pAccessMode
