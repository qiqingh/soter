	local phy="$1"
	local ifname="$2"
	local type="$3"
	local wdsflag="$4"
	local rc
	local oldifname

	iw phy "$phy" interface add "$ifname" type "$type" $wdsflag >/dev/null 2>&1
	rc="$?"

	[ "$rc" = 233 ] && {
		# Device might have just been deleted, give the kernel some time to finish cleaning it up
		sleep 1

		iw phy "$phy" interface add "$ifname" type "$type" $wdsflag >/dev/null 2>&1
		rc="$?"
	}

	[ "$rc" = 233 ] && {
		# Keep matching pre-existing interface
		[ -d "/sys/class/ieee80211/${phy}/device/net/${ifname}" ] && \
		case "$(iw dev $ifname info | grep "^\ttype" | cut -d' ' -f2- 2>/dev/null)" in
			"AP")
				[ "$type" = "__ap" ] && rc=0
				;;
			"IBSS")
				[ "$type" = "adhoc" ] && rc=0
				;;
			"managed")
				[ "$type" = "managed" ] && rc=0
				;;
			"mesh point")
				[ "$type" = "mp" ] && rc=0
				;;
			"monitor")
				[ "$type" = "monitor" ] && rc=0
				;;
		esac
	}

	[ "$rc" = 233 ] && {
		iw dev "$ifname" del >/dev/null 2>&1
		[ "$?" = 0 ] && {
			sleep 1

			iw phy "$phy" interface add "$ifname" type "$type" $wdsflag >/dev/null 2>&1
			rc="$?"
		}
	}

	[ "$rc" != 0 ] && {
		# Device might not support virtual interfaces, so the interface never got deleted in the first place.
		# Check if the interface already exists, and avoid failing in this case.
		[ -d "/sys/class/ieee80211/${phy}/device/net/${ifname}" ] && rc=0
	}

	[ "$rc" != 0 ] && {
		# Device doesn't support virtual interfaces and may have existing interface other than ifname.
		oldifname="$(basename "/sys/class/ieee80211/${phy}/device/net"/* 2>/dev/null)"
		[ "$oldifname" ] && ip link set "$oldifname" name "$ifname" 1>/dev/null 2>&1
		rc="$?"
	}

	[ "$rc" != 0 ] && wireless_setup_failed INTERFACE_CREATION_FAILED
	return $rc
