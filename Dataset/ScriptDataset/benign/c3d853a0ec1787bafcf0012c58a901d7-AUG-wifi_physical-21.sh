	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_CTSPROTECTION=`syscfg_get "$SYSCFG_INDEX"_cts_protection_mode`
	HTPROTECT=0
	if [ "auto" = "$SYSCFG_CTSPROTECTION" ]; then
		HTPROTECT=1
	fi
	iwpriv $PHY_IF extprotmode $HTPROTECT
	return 0
