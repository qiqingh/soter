	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
		
	AC_SUPPORTED=`is_11ac_supported $WL_SYSCFG`
