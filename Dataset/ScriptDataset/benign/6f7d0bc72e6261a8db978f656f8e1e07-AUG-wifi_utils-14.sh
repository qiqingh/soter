	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$1"_syscfg_index`
	echo "$SYSCFG_INDEX"
