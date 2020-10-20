	local config="$1"
	local driver="$2"

	local base="${config%%.conf}"
	local base_cfg=

	json_get_vars country country_ie beacon_int doth require_mode

	hostapd_set_log_options base_cfg

	set_default country_ie 1
	set_default doth 1

	[ -n "$country" ] && {
		append base_cfg "country_code=$country" "$N"

		[ "$country_ie" -gt 0 ] && append base_cfg "ieee80211d=1" "$N"
		[ "$hwmode" = "a" -a "$doth" -gt 0 ] && append base_cfg "ieee80211h=1" "$N"
	}
	[ -n "$hwmode" ] && append base_cfg "hw_mode=$hwmode" "$N"

	local brlist= br
	json_get_values basic_rate_list basic_rate
	for br in $basic_rate_list; do
		hostapd_add_rate brlist "$br"
	done
	case "$require_mode" in
		g) brlist="60 120 240" ;;
		n) append base_cfg "require_ht=1" "$N";;
		ac) append base_cfg "require_vht=1" "$N";;
	esac

	local rlist= r
	json_get_values rate_list supported_rates
	for r in $rate_list; do
		hostapd_add_rate rlist "$r"
	done

	[ -n "$rlist" ] && append base_cfg "supported_rates=$rlist" "$N"
	[ -n "$brlist" ] && append base_cfg "basic_rates=$brlist" "$N"
	[ -n "$beacon_int" ] && append base_cfg "beacon_int=$beacon_int" "$N"

	cat > "$config" <<EOF
driver=$driver
$base_cfg
EOF
