	SYSCFG=$1
	INF=""
	if [ "$SYSCFG" = "`syscfg_get ath0_syscfg_index`" ]; then
		INF="ath0"
	else
		INF="ath1"
	fi
	echo "$INF"
