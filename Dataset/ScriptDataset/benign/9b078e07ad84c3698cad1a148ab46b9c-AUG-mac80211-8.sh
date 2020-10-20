	[ -n "$phy" -a -d /sys/class/ieee80211/$phy ] && return 0
	[ -n "$path" ] && {
		phy="$(mac80211_path_to_phy "$path")"
		[ -n "$phy" ] && return 0
	}
	[ -n "$macaddr" ] && {
		for phy in $(ls /sys/class/ieee80211 2>/dev/null); do
			grep -i -q "$macaddr" "/sys/class/ieee80211/${phy}/macaddress" && return 0
		done
	}
	return 1
