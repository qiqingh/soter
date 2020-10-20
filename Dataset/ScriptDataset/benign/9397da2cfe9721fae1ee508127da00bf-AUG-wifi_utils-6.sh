	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	DFS=`syscfg_get "$SYSCFG_INDEX"_dfs_enabled`
	if [ "1" = "$DFS" ]; then
		iwpriv $PHY_IF blockdfschan 0
	else
		iwpriv $PHY_IF blockdfschan 1
	fi
