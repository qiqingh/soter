	local ifname="$1"

	iwpriv "$ifname" set RekeyMethod=TIME
	iwpriv "$ifname" set RekeyInterval=$wpa_group_rekey
