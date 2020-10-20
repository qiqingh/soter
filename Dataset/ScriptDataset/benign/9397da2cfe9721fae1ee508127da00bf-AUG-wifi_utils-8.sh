	PHY_IF=$1
	INF=""
	if [ "$PHY_IF" = "ath0" -o "$PHY_IF" = "ath2" ]; then
		INF="wifi0"
	else
		INF="wifi1"
	fi
	echo "$INF"
