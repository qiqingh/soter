	local name="$1"

	local ifname="$sta_ifname"
	json_select config
	json_get_vars mode apname ssid encryption key key1 key2 key3 key4 wps_pushbutton

	key=
	case "$encryption" in
		psk*|mixed*) json_get_vars key;;
		wep) json_get_var key key1;;
	esac
	json_select ..

	/sbin/ap_client "$apname" "$ifname" "${ssid}" "${key}"
	sleep 1
	wireless_add_process "$(cat /tmp/apcli-${ifname}.pid)" /sbin/ap_client $apname $ifname ${ssid} ${key}

	wireless_add_vif "$name" "$ifname"
