	echo "${SERVICE_NAME}, modem_set_state()" > /dev/console
	ulog wlan status "${SERVICE_NAME}, modem_set_state()"
	STATE=$1
	ulog wlan status "${SERVICE_NAME}, modem_set_state(state=$STATE)"
	
	case "$STATE" in
		"CONFIGURING" | "CONFIGURED" | "NOTCONFIGURED" | "FAILED")
			sysevent set modem_state $STATE
			;;
		*)
			echo "${SERVICE_NAME}, Error: Invalid state in modem_set_state(state=$STATE)"  1>&2
			ulog wlan status "${SERVICE_NAME}, Error: Invalid state in modem_set_state(state=$STATE)"  1>&2
			return 1
			;;
	esac
	return 0
