	local name="$1"
	local failed

	json_select data
	json_get_vars ifname
	json_select ..

	json_select config
	json_get_vars mode
	json_get_var vif_txpower txpower

	ip link set dev "$ifname" up || {
		wireless_setup_vif_failed IFUP_ERROR
		json_select ..
		return
	}

	set_default vif_txpower "$txpower"
	[ -z "$vif_txpower" ] || iw dev "$ifname" set txpower fixed "${vif_txpower%%.*}00"

	case "$mode" in
		mesh)
			wireless_vif_parse_encryption
			freq="$(get_freq "$phy" "$channel")"
			if [ "$wpa" -gt 0 -o "$auto_channel" -gt 0 ] || chan_is_dfs "$phy" "$channel"; then
				mac80211_setup_supplicant || failed=1
			else
				mac80211_setup_mesh
			fi
			for var in $MP_CONFIG_INT $MP_CONFIG_BOOL $MP_CONFIG_STRING; do
				json_get_var mp_val "$var"
				[ -n "$mp_val" ] && iw dev "$ifname" set mesh_param "$var" "$mp_val"
			done
		;;
		adhoc)
			wireless_vif_parse_encryption
			mac80211_setup_adhoc_htmode
			if [ "$wpa" -gt 0 -o "$auto_channel" -gt 0 ]; then
				freq="$(get_freq "$phy" "$channel")"
				mac80211_setup_supplicant_noctl || failed=1
			else
				mac80211_setup_adhoc
			fi
		;;
		sta)
			mac80211_setup_supplicant || failed=1
		;;
	esac

	json_select ..
	[ -n "$failed" ] || wireless_add_vif "$name" "$ifname"
