    PHY_IF=$1
    SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
    SEC_MODE=`get_security_mode "$SYSCFG_INDEX"_security_mode`
    if [ "$SEC_MODE" = "4" -o "$SEC_MODE" = "5" -o "$SEC_MODE" = "6" -o "$SEC_MODE" = "7" ]; then
	start_radius_ea7300_helper $SYSCFG_INDEX
    fi
