	STA_VIR_IF=`syscfg_get wifi_sta_vir_if`
	iwconfig $STA_VIR_IF | grep "Channel:" | awk -F':' '{print $2}' | awk '{print $1}'
