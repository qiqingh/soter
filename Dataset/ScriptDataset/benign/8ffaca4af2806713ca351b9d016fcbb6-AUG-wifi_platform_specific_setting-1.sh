	PHY_IF=$1
	MBSS_ENABLED=`wl -i $PHY_IF mbss`
	return ${MBSS_ENABLED}
