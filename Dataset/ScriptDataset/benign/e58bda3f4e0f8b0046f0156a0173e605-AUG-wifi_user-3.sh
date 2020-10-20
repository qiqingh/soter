	PHY_IF=$1
	VIR_IF=$1
	set_wps_state ${SYSCFG_INDEX} $PHY_IF
	set_ea7500_thermal ${SYSCFG_INDEX} $PHY_IF
	configure_user $PHY_IF $VIR_IF
	ret=$?
