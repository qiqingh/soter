	PHY_IF=$1
	OBSS_COEX=`syscfg_get obss_coex_enable`
	if [ "ra0" != "$PHY_IF" ]; then
		return
	fi
	if [ "1" = "$OBSS_COEX" ]; then
		set_wifi_val $PHY_IF HT_BSSCoexistence 1
	else
		set_wifi_val $PHY_IF HT_BSSCoexistence 0
	fi
