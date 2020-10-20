	local cfg="led_$1"
	local name=$2
	local sysfs=$3
	local trigger=$4
	local port_mask=$5

	uci -q get system.$cfg && return 0

	uci batch <<EOF
set system.$cfg='led'
set system.$cfg.name='$name'
set system.$cfg.sysfs='$sysfs'
set system.$cfg.trigger='$trigger'
set system.$cfg.port_mask='$port_mask'
EOF
	UCIDEF_LEDS_CHANGED=1
