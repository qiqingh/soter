	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	SYSCFG_NETWORK_MODE=""
	RET_STR="false"
	
	SYSCFG_NETWORK_MODE=`syscfg_get "$SYSCFG_INDEX"_network_mode`
	case "$SYSCFG_NETWORK_MODE" in
		"11a")
			RET_STR="true"
			;;
		"11b 11g")
			RET_STR="true"
			;;
		"11b")
			RET_STR="true"
			;;
		"11g")
			RET_STR="true"
			;;
		*)
			RET_STR="false"
			;;
	esac
	echo "$RET_STR"
