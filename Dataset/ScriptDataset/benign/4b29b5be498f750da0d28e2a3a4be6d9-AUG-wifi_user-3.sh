	PHY_IF=$1
	echo "${SERVICE_NAME}, wifi_user_restart($PHY_IF)"
	wifi_user_stop $PHY_IF
	wifi_user_start $PHY_IF
	return 0
