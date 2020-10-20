	local freq="$1"
	local htmode="$2"

	append network_data "fixed_freq=1" "$N$T"
	append network_data "frequency=$freq" "$N$T"
	case "$htmode" in
		NOHT) append network_data "disable_ht=1" "$N$T";;
		HT20|VHT20) append network_data "disable_ht40=1" "$N$T";;
		HT40*|VHT40*|VHT80*|VHT160*) append network_data "ht40=1" "$N$T";;
	esac
	case "$htmode" in
		VHT*) append network_data "vht=1" "$N$T";;
	esac
	case "$htmode" in
		VHT80) append network_data "max_oper_chwidth=1" "$N$T";;
		VHT160) append network_data "max_oper_chwidth=2" "$N$T";;
		*) append network_data "max_oper_chwidth=0" "$N$T";;
	esac
