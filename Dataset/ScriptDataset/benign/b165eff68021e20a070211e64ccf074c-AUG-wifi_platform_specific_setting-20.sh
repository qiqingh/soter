	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	AC_SUPPORTED=`is_11ac_supported $WL_SYSCFG`
	if [ "$AC_SUPPORTED" = "0" ]; then
		MIMO_PREAMBLE=`syscfg get "$WL_SYSCFG"_grn_field_pre`
		if [ "enabled" = "$MIMO_PREAMBLE" ]; then
			wl -i $PHY_IF mimo_preamble 1
		else 
			wl -i $PHY_IF mimo_preamble 0
		fi
	fi
