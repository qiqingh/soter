	local count="$1"
	case "$variant" in
		mt7620) module=rt2860v2_ap;;
		mt7603) module=mt7603e;;
		mt76x2) module=MT76x2_ap;;
		rt5592) module=RTPCI_ap;;
		*) return;;
	esac
	[ -f "/tmp/${module}_bss" ] && {
		prev_count="$(cat /tmp/${module}_bss)"
		[ "$prev_count" -lt "$count" ] || return
		rmmod "$module"
		insmod "$module"
	}
	echo "$count" > "/tmp/${module}_bss"
