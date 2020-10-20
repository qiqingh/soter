	local phy="$1"
	local ifname="$2"
	local type="$3"
	local wdsflag="$4"
	local rc

	iw phy "$phy" interface add "$ifname" type "$type" $wdsflag
	rc="$?"

	[ "$rc" = 233 ] && {
		# Device might have just been deleted, give the kernel some time to finish cleaning it up
		sleep 1

		iw phy "$phy" interface add "$ifname" type "$type" $wdsflag
		rc="$?"
	}

	[ "$rc" = 233 ] && {
		# Device might not support virtual interfaces, so the interface never got deleted in the first place.
		# Check if the interface already exists, and avoid failing in this case.
		ip link show dev "$ifname" >/dev/null 2>/dev/null && rc=0
	}

	[ "$rc" != 0 ] && wireless_setup_failed INTERFACE_CREATION_FAILED
	return $rc
