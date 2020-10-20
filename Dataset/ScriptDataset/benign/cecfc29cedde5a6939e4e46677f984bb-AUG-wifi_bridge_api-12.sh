	PHY_IF=$1
	WLINDEX=$2
	RADIO=$3
	echo "${SERVICE_NAME}, restoring user defined settings on $RADIO"
	if [ "down" = `syscfg_get $WLINDEX"_state"` ]; then
		ifconfig $PHY_IF down
		return 0
	fi
	set_driver_htbw $PHY_IF
	set_driver_extsubch $PHY_IF
	set_driver_channel $PHY_IF
	set_driver_wmm $PHY_IF
	set_driver_opmode $PHY_IF
	sleep 1
	iwconfig $PHY_IF commit
	echo "${SERVICE_NAME}, restore user vap"
	ifconfig $PHY_IF"ap0" up
	if [ "1" = `syscfg_get guest_enabled` ] && [ "1" = `syscfg_get $WLINDEX"_guest_enabled"` ]; then
		echo "${SERVICE_NAME}, restore guest vap"
		GUEST=`syscfg_get $WLINDEX"_guest_vap"`
		ifconfig $GUEST up
	fi
