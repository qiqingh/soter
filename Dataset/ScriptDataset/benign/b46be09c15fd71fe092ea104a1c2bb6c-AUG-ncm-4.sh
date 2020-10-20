	local interface="$1"

	local manufacturer disconnect

	local device profile
	json_get_vars device profile

	[ -n "$ctl_device" ] && device=$ctl_device

	[ -n "$profile" ] || profile=1

	echo "Stopping network $interface"

	json_load "$(ubus call network.interface.$interface status)"
	json_select data
	json_get_vars manufacturer

	json_load "$(cat /etc/gcom/ncm.json)"
	json_select "$manufacturer" || {
		echo "Unsupported modem"
		proto_notify_error "$interface" UNSUPPORTED_MODEM
		return 1
	}

	json_get_vars disconnect
	eval COMMAND="$disconnect" gcom -d "$device" -s /etc/gcom/runcommand.gcom || {
		echo "Failed to disconnect"
		proto_notify_error "$interface" DISCONNECT_FAILED
		return 1
	}

	proto_init_update "*" 0
	proto_send_update "$interface"
