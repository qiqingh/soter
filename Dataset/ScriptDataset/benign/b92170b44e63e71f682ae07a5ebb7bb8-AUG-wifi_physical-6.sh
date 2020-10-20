	ulog wlan status "${SERVICE_NAME}, physical_post_setting($1)"
	PHY_IF=$1
	LDAL_ENABLED=`syscfg_get lego_enabled`
	LDAL_VSTA=`syscfg_get ldal_wl_vsta`
	if [ ! -z "$LDAL_ENABLED" ] && [ "$LDAL_ENABLED" = "1" ]; then
		if [ -z "$LDAL_VSTA" ]; then
			ulog wlan status "${SERVICE_NAME}, fire up the infra vap first" > /dev/console
			sysevent set ldal_infra_vap-stop
			sysevent set ldal_infra_vap-start
		else
			EDALSETTINGFILE="/var/config/ldal/edalsettingd.cfg"
			if [ ! -f $EDALSETTINGFILE ]; then
				ulog wlan status "${SERVICE_NAME}, force to edal setup on the first boot" > /dev/console
				syscfg_set ldal_wl_station_state unconfigured
			fi
			ulog wlan status "${SERVICE_NAME}, fire up the station connect first" > /dev/console
			sysevent set ldal_station_connect-stop
			sysevent set ldal_station_connect-start
		fi
	fi
	return 0
