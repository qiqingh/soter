	PHY_IF=$1
	if [ "0" != "`wl -i ${PHY_IF} obss_coex`" ]; then 		
		wl -i ${PHY_IF} obss_coex 0
	fi
