	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	if [ "wl0" = "$WL_SYSCFG" ]; then
		is_mbss_needed ${PHY_IF}
		if [ "$?" = "0" ]; then 
			disable_mbss ${PHY_IF}
		fi
	fi
