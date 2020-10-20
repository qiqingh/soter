	json_load "$data"

	json_select config
	_wdev_prepare_channel
	json_select ..

	eval "drv_$1_$2 \"$interface\""
