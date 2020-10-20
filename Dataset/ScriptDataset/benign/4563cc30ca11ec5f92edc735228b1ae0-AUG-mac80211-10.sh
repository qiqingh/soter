	json_select config

	json_get_vars ifname mode ssid wds powersave macaddr

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
	json_select config

	# It is far easier to delete and create the desired interface
	case "$mode" in
		adhoc)
			iw phy "$phy" interface add "$ifname" type adhoc
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

			[ -n "$hostapd_ctrl" ] || {
				iw phy "$phy" interface add "$ifname" type __ap
				hostapd_ctrl="${hostapd_ctrl:-/var/run/hostapd/$ifname}"
			}
		;;
		mesh)
			iw phy "$phy" interface add "$ifname" type mp
		;;
		monitor)
			iw phy "$phy" interface add "$ifname" type monitor
		;;
		sta)
			local wdsflag=
			staidx="$(($staidx + 1))"
			[ "$wds" -gt 0 ] && wdsflag="4addr on"
			iw phy "$phy" interface add "$ifname" type managed $wdsflag
			[ "$powersave" -gt 0 ] && powersave="on" || powersave="off"
			iw "$ifname" set power_save "$powersave"
		;;
	esac

	case "$mode" in
		monitor|mesh)
			[ "$auto_channel" -gt 0 ] || iw dev "$ifname" set channel "$channel" $htmode
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
