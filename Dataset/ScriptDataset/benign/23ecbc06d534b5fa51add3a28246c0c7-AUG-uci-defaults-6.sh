	local cfg="led_$1"
	local name=$2
	local sysfs=$3
	local iface=$4
	local minq=$5
	local maxq=$6
	local offset=$7
	local factor=$8

	uci -q get system.$cfg && return 0

	uci batch <<EOF
set system.$cfg='led'
set system.$cfg.name='$name'
set system.$cfg.sysfs='$sysfs'
set system.$cfg.trigger='rssi'
set system.$cfg.iface='rssid_$iface'
set system.$cfg.minq='$minq'
set system.$cfg.maxq='$maxq'
set system.$cfg.offset='$offset'
set system.$cfg.factor='$factor'
EOF
	UCIDEF_LEDS_CHANGED=1
