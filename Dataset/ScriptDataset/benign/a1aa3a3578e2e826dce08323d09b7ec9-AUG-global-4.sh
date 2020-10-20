	ec=`nvram_get 2860 ethConvert`
	if [ "$opmode" = "0" -a "$CONFIG_RT2860V2_STA_DPB" = "y" -a "$ec" = "1" ]; then
		ethconv="y"
	elif [ "$opmode" = "0" -a "$CONFIG_RLT_STA_SUPPORT" != "" ]; then
		ethconv="y"
	else
		ethconv="n"
	fi
