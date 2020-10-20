	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_CTSPROTECTION=`syscfg_get "$SYSCFG_INDEX"_cts_protection_mode`
	GPROTECT=0
	if [ "auto" = "$SYSCFG_CTSPROTECTION" ]; then
		if [ "$SYSCFG_INDEX" = "wl0" ]; then
			GPROTECT=1
		fi
	fi
	iwpriv $PHY_IF protmode $GPROTECT
	return 0
