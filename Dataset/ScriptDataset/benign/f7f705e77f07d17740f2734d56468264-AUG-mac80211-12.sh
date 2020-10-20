	local enable=$1
	local add_sp=0
	local spobj="$(ubus -S list | grep wpa_supplicant.${ifname})"

	[ "$enable" = 0 ] && {
		ubus call wpa_supplicant.${phy} config_del "{\"iface\":\"$ifname\"}"
		ip link set dev "$ifname" down
		iw dev "$ifname" del
		return 0
	}

	wpa_supplicant_prepare_interface "$ifname" nl80211 || {
		iw dev "$ifname" del
		return 1
	}
	if [ "$mode" = "sta" ]; then
		wpa_supplicant_add_network "$ifname"
	else
		wpa_supplicant_add_network "$ifname" "$freq" "$htmode" "$noscan"
	fi

	NEWSPLIST="${NEWSPLIST}$ifname "

	if [ "${NEWAPLIST%% *}" != "${OLDAPLIST%% *}" ]; then
		[ "$spobj" ] && ubus call wpa_supplicant config_remove "{\"iface\":\"$ifname\"}"
		add_sp=1
	fi
	[ -z "$spobj" ] && add_sp=1

	NEW_MD5_SP=$(test -e "${_config}" && md5sum ${_config})
	OLD_MD5_SP=$(uci -q -P /var/state get wireless._${phy}.md5_${ifname})
	if [ "$add_sp" = "1" ]; then
		wpa_supplicant_run "$ifname" "$hostapd_ctrl"
	else
		[ "${NEW_MD5_SP}" == "${OLD_MD5_SP}" ] || ubus call $spobj reload
	fi
	uci -q -P /var/state set wireless._${phy}.md5_${ifname}="${NEW_MD5_SP}"
	return 0
