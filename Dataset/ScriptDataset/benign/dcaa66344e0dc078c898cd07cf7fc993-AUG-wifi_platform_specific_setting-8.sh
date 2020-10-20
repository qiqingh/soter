	for PHY_IF in $PHYSICAL_IF_LIST; do
		WL_SYSCFG=`get_syscfg_interface_name $PHY_IF`	
		USER_VAP_STATE=`syscfg get ${WL_SYSCFG}_state`
		USER_VAP=`syscfg get ${WL_SYSCFG}_user_vap`
		if [ "down" = "$USER_VAP_STATE" ]; then
			if [ -z "$USER_VAP" ]; then
				continue
			fi
			wl -i $USER_VAP ssid "" > /dev/null
			wl -i $USER_VAP down
		else #else bring vap up
			if [ -z "$USER_VAP" ]; then
				continue
			fi
			wl -i $USER_VAP up
		fi
	done
