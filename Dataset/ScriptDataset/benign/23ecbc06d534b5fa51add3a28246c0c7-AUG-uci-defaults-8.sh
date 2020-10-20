	local cfg="led_$1"
	local name=$2
	local sysfs=$3
	local trigger=$4

	uci -q get system.$cfg && return 0

	uci batch <<EOF
set system.$cfg='led'
set system.$cfg.name='$name'
set system.$cfg.sysfs='$sysfs'
set system.$cfg.trigger='$trigger'
EOF
	UCIDEF_LEDS_CHANGED=1
