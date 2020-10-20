	PHY_IF=$1
	wait_till_end_state ${PHYSICAL_ACTION}_${PHY_IF}
	VALID=`is_physical_interface_valid ${PHY_IF}`
	if [ "$VALID" = "0" ]; then
		echo "Invalid interface: ${PHY_IF}"
		return 0
	fi
	STATUS=`sysevent get ${PHYSICAL_ACTION}_${PHY_IF}-status`
	if [ "stopping" = "$STATUS" ] || [ "stopped" = "$STATUS" ] || [ -z "$STATUS" ]; then
		ulog wlan status "${SERVICE_NAME}, ${PHYSICAL_ACTION}_${PHY_IF} is already stopping/stopped, ignore the request"
		return 0
	fi
	ulog wlan status "${SERVICE_NAME}, wifi_physical_action_stop(${PHY_IF})"
	sysevent set ${PHYSICAL_ACTION}_${PHY_IF}-status stopping
	bring_phy_if_down ${PHY_IF}
	clean_settings $PHY_IF
	unconfigure_mbss $PHY_IF
	sysevent set ${PHYSICAL_ACTION}_${PHY_IF}-status stopped
