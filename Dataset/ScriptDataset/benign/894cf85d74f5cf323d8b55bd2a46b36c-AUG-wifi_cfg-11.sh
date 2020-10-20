	wifi_band=$1
	wifi_val2=$2
	wifi_val5=$3
	if [ "null" = "$wifi_val2" ]; then
		wifi_val2=""
	fi
	if [ "null" = "$wifi_val5" ]; then
		wifi_val5=""
	fi
	if [ "5" = "$wifi_band" ]; then
		echo "$wifi_val5"
	else
		echo "$wifi_val2"
	fi
