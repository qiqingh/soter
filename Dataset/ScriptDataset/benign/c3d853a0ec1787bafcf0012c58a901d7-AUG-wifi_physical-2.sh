	ulog wlan status "${SERVICE_NAME}, wifi_physical_stop($1)"
	echo "${SERVICE_NAME}, wifi_physical_stop($1)"
	PHY_IF=$1
	if [ -z "$PHY_IF" ]; then
		echo "${SERVICE_NAME}, ${WIFI_USER} ERROR: invalid interface name, ignore the request"
		ulog wlan status "${SERVICE_NAME}, ${WIFI_USER} ERROR: invalid interface name, ignore the request"
		return 1
	fi
	wait_till_end_state ${WIFI_PHYSICAL}_${PHY_IF}
	STATUS=`sysevent get ${WIFI_PHYSICAL}_${PHY_IF}-status`
	if [ "stopping" = "$STATUS" ] || [ "stopped" = "$STATUS" ] || [ -z "$STATUS" ]; then
		ulog wlan status "${SERVICE_NAME}, ${WIFI_PHYSICAL} is already stopping/stopped, ignore the request"
		return 1
	fi
	STA_PHY_IF=`syscfg_get wifi_sta_phy_if`
	if [ "2" = "`syscfg_get wifi_bridge::mode`" ] && [ "$PHY_IF" = "$STA_PHY_IF" ]; then
		echo "${SERVICE_NAME}, $PHY_IF is in repeater mode, do not stop this physical interface"
		return 1
	fi
        
	sysevent set ${WIFI_PHYSICAL}_${PHY_IF}-status stopping
	if [ "`sysevent get ldal_setup_vap-status`" = "started" ]; then
		sysevent set ldal_setup_vap-stop
		wait_till_end_state ldal_setup_vap
	fi
	
	if [ "`sysevent get ldal_infra_vap-status`" = "started" ]; then
		sysevent set ldal_infra_vap-stop
		wait_till_end_state ldal_infra_vap
	fi
	
	if [ "`sysevent get ldal_station_connect-status`" = "started" ]; then
		sysevent set ldal_station_connect-stop
		wait_till_end_state ldal_station_connect
	fi
	
	sysevent set ${WIFI_PHYSICAL}_${PHY_IF}-status stopped
	return 0
