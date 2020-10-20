	local interface="$1"

	local manufacturer disconnect

	local device profile
	json_get_vars device profile

	[ -n "$ctl_device" ] && device=$ctl_device

	[ -n "$device" ] || {
		echo "No control device specified"
		proto_notify_error "$interface" NO_DEVICE
		proto_set_available "$interface" 0
		return 1
	}

	device="$(readlink -f $device)"
	[ -e "$device" ] || {
		echo "Control device not valid"
		proto_set_available "$interface" 0
		return 1
	}

	[ -n "$profile" ] || profile=1

	echo "Stopping network $interface"

	json_load "$(ubus call network.interface.$interface status)"
	json_select data
	json_get_vars manufacturer
	[ $? -ne 0 -o -z "$manufacturer" ] && {
		# Fallback to direct detect, for proper handle device replug.
		manufacturer=$(gcom -d "$device" -s /etc/gcom/getcardinfo.gcom | awk 'NF && $0 !~ /AT\+CGMI/ { sub(/\+CGMI: /,""); print tolower($1); exit; }')
		[ $? -ne 0 -o -z "$manufacturer" ] && {
			echo "Failed to get modem information"
			proto_notify_error "$interface" GETINFO_FAILED
			return 1
		}
		json_add_string "manufacturer" "$manufacturer"
	}

	json_load "$(cat /etc/gcom/ncm.json)"
	json_select "$manufacturer" || {
		echo "Unsupported modem"
		proto_notify_error "$interface" UNSUPPORTED_MODEM
		return 1
	}

	json_get_vars disconnect
	[ -n "$disconnect" ] && {
		eval COMMAND="$disconnect" gcom -d "$device" -s /etc/gcom/runcommand.gcom || {
			echo "Failed to disconnect"
			proto_notify_error "$interface" DISCONNECT_FAILED
			return 1
		}
	}

	proto_init_update "*" 0
	proto_send_update "$interface"
