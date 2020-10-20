	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_CTSPROTECTION=`syscfg_get "$SYSCFG_INDEX"_cts_protection_mode`
	if [ "$SYSCFG_INDEX" != "wl0" ]; then
		return 0
	fi
	if [ "disabled" != "$SYSCFG_CTSPROTECTION" ]; then
		set_wifi_val $PHY_IF BGProtection 0
        echo "${SERVICE_NAME}, BGProtection 0"
	else
		set_wifi_val $PHY_IF BGProtection 2
        echo "${SERVICE_NAME}, BGProtection 2"
	fi
	return 0
