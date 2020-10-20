	local device="$1"
	local vif vifs wds
	local adhoc sta apmode mon disabled
	local adhoc_if sta_if ap_if mon_if

	config_get vifs "$device" vifs
	for vif in $vifs; do
		config_get_bool disabled "$vif" disabled 0
		[ $disabled -eq 0 ] || continue

		local mode
		config_get mode "$vif" mode
		case "$mode" in
			adhoc)
				adhoc=1
				adhoc_if="$vif"
			;;
			sta)
				sta=1
				sta_if="$vif"
			;;
			ap)
				apmode=1
				ap_if="${ap_if:+$ap_if }$vif"
			;;
			wds)
				local addr
				config_get addr "$vif" bssid
				[ -z "$addr" ] || {
					addr=$(echo "$addr" | tr 'A-F' 'a-f')
					append wds "$addr"
				}
			;;
			monitor)
				mon=1
				mon_if="$vif"
			;;
			*) echo "$device($vif): Invalid mode";;
		esac
	done
	config_set "$device" wds "$wds"

	local _c=
	for vif in ${adhoc_if:-$sta_if $ap_if $mon_if}; do
		config_set "$vif" ifname "${device}${_c:+-$_c}"
		_c=$((${_c:-0} + 1))
	done
	config_set "$device" vifs "${adhoc_if:-$sta_if $ap_if $mon_if}"

	ap=1
	infra=1
	if [ "$_c" -gt 1 ]; then
		mssid=1
	else
		mssid=
	fi
	apsta=0
	radio=1
	monitor=0
	case "$adhoc:$sta:$apmode:$mon" in
		1*)
			ap=0
			mssid=
			infra=0
		;;
		:1:1:)
			apsta=1
			wet=1
		;;
		:1::)
			wet=1
			ap=0
			mssid=
		;;
		:::1)
			wet=1
			ap=0
			mssid=
			monitor=1
		;;
		::)
			radio=0
		;;
	esac
