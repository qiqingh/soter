	json_select config

	json_get_vars ifname mode ssid wds powersave macaddr enable wpa_psk_file vlan_file

	[ -n "$ifname" ] || ifname="wlan${phy#phy}${if_idx:+-$if_idx}"
	if_idx=$((${if_idx:-0} + 1))

	set_default wds 0
	set_default powersave 0

	json_select ..

	[ -n "$macaddr" ] || {
		macaddr="$(mac80211_generate_mac $phy)"
		macidx="$(($macidx + 1))"
	}

	json_add_object data
	json_add_string ifname "$ifname"
	json_close_object

	[ "$mode" == "ap" ] && {
		[ -z "$wpa_psk_file" ] && hostapd_set_psk "$ifname"
		[ -z "$vlan_file" ] && hostapd_set_vlan "$ifname"
	}

	json_select config

	# It is far easier to delete and create the desired interface
	case "$mode" in
		adhoc)
			mac80211_iw_interface_add "$phy" "$ifname" adhoc || return
		;;
		ap)
			# Hostapd will handle recreating the interface and
			# subsequent virtual APs belonging to the same PHY
			if [ -n "$hostapd_ctrl" ]; then
				type=bss
			else
				type=interface
			fi

			mac80211_hostapd_setup_bss "$phy" "$ifname" "$macaddr" "$type" || return

			NEWAPLIST="${NEWAPLIST}$ifname "
			[ -n "$hostapd_ctrl" ] || {
				ap_ifname="${ifname}"
				hostapd_ctrl="${hostapd_ctrl:-/var/run/hostapd/$ifname}"
			}
		;;
		mesh)
			mac80211_iw_interface_add "$phy" "$ifname" mp || return
		;;
		monitor)
			mac80211_iw_interface_add "$phy" "$ifname" monitor || return
		;;
		sta)
			local wdsflag=
			[ "$enable" = 0 ] || staidx="$(($staidx + 1))"
			[ "$wds" -gt 0 ] && wdsflag="4addr on"
			mac80211_iw_interface_add "$phy" "$ifname" managed "$wdsflag" || return
			if [ "$wds" -gt 0 ]; then
				iw "$ifname" set 4addr on
			else
				iw "$ifname" set 4addr off
			fi
			[ "$powersave" -gt 0 ] && powersave="on" || powersave="off"
			iw "$ifname" set power_save "$powersave"
		;;
	esac

	case "$mode" in
		monitor|mesh)
			[ "$auto_channel" -gt 0 ] || iw dev "$ifname" set channel "$channel" $iw_htmode
		;;
	esac

	if [ "$mode" != "ap" ]; then
		# ALL ap functionality will be passed to hostapd
		# All interfaces must have unique mac addresses
		# which can either be explicitly set in the device
		# section, or automatically generated
		ip link set dev "$ifname" address "$macaddr"
	fi

	json_select ..
