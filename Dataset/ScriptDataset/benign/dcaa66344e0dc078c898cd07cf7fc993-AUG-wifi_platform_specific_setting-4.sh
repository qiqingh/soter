	PHY_IF=$1
	WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`
	MBSS_ENABLED=`wl -i $PHY_IF mbss`
	if [ "${MBSS_ENABLED}" = "1" ]; then 
		wl -i $PHY_IF mbss 0
		wl -i $PHY_IF bss -C $MBSS_PRIMARY down
		wl -i $PHY_IF bss -C $MBSS_GUEST down
		if [ ${WL_SYSCFG} = "wl0" ]; then
			wl -i $PHY_IF bss -C $MBSS_SIMPLETAP down
		fi
		ulog wlan status "${SERVICE_NAME}, disable mbss: $PHY_IF"
	else
		ulog wlan status "${SERVICE_NAME}, Warning: can not delete mbss from $PHY_IF, mbss did not exist"
		return 1
	fi
	return 0
