	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_CTSPROTECTION=`syscfg_get "$SYSCFG_INDEX"_cts_protection_mode`
	HTPROTECT=1
	if [ "disabled" = "$SYSCFG_CTSPROTECTION" ]; then
		HTPROTECT=0
	fi
	set_wifi_val $PHY_IF HT_PROTECT $HTPROTECT
	return 0
