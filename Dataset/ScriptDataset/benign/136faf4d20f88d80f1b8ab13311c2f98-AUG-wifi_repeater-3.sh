	echo "${SERVICE_NAME}, init()"
	echo "$SERVICE_NAME, creating STA vap $STA_IF"
	brctl addif $BRIDGE_NAME $STA_IF
