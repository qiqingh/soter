	local auth_type="$(echo $auth_type | tr 'a-z' 'A-Z')"

	append wpa_key_mgmt "WPA-$auth_type"
	[ "${ieee80211r:-0}" -gt 0 ] && append wpa_key_mgmt "FT-${auth_type}"
	[ "${ieee80211w:-0}" -gt 0 ] && append wpa_key_mgmt "WPA-${auth_type}-SHA256"
