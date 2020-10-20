	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	AUTO_CHANNEL=`syscfg get "$WL_SYSCFG"_channel`
		wl -i $PHY_IF chanim_mode 2 
