	local phy="$1"
	local idx="$(($2 + 1))"

	head -n $(($macidx + 1)) /sys/class/ieee80211/${phy}/addresses | tail -n1
