	local phy="$1"
	local primary_ap=$(uci -q -P /var/state get wireless._${phy}.aplist)
	primary_ap=${primary_ap%% *}

	mac80211_vap_cleanup hostapd "${primary_ap}"
	mac80211_vap_cleanup wpa_supplicant "$(uci -q -P /var/state get wireless._${phy}.splist)"
	mac80211_vap_cleanup none "$(uci -q -P /var/state get wireless._${phy}.umlist)"
