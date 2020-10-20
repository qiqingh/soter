	local config="$1"
	local driver="$2"

	local base="${config%%.conf}"
	local base_cfg=

	json_get_vars country country_ie beacon_int:100 doth require_mode legacy_rates

	hostapd_set_log_options base_cfg

	set_default country_ie 1
	set_default doth 1
	set_default legacy_rates 1

	[ "$hwmode" = "b" ] && legacy_rates=1

	[ -n "$country" ] && {
		append base_cfg "country_code=$country" "$N"

		[ "$country_ie" -gt 0 ] && append base_cfg "ieee80211d=1" "$N"
		[ "$hwmode" = "a" -a "$doth" -gt 0 ] && append base_cfg "ieee80211h=1" "$N"
	}

	local brlist= br
	json_get_values basic_rate_list basic_rate
	local rlist= r
	json_get_values rate_list supported_rates

	[ -n "$hwmode" ] && append base_cfg "hw_mode=$hwmode" "$N"
	[ "$legacy_rates" -eq 0 ] && set_default require_mode g

	[ "$hwmode" = "g" ] && {
		[ "$legacy_rates" -eq 0 ] && set_default rate_list "6000 9000 12000 18000 24000 36000 48000 54000"
		[ -n "$require_mode" ] && set_default basic_rate_list "6000 12000 24000"
	}

	case "$require_mode" in
		n) append base_cfg "require_ht=1" "$N";;
		ac) append base_cfg "require_vht=1" "$N";;
	esac

	for r in $rate_list; do
		hostapd_add_rate rlist "$r"
	done

	for br in $basic_rate_list; do
		hostapd_add_rate brlist "$br"
	done

	[ -n "$rlist" ] && append base_cfg "supported_rates=$rlist" "$N"
	[ -n "$brlist" ] && append base_cfg "basic_rates=$brlist" "$N"
	append base_cfg "beacon_int=$beacon_int" "$N"

	cat > "$config" <<EOF
driver=$driver
$base_cfg
EOF
