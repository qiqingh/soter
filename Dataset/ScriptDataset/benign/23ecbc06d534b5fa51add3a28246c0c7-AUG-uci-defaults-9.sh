	local dev="$1"
	local refresh="$2"
	local threshold="$3"

	local cfg="rssid_$dev"

	uci -q get system.$cfg && return 0

	uci batch <<EOF
set system.$cfg='rssid'
set system.$cfg.dev='$dev'
set system.$cfg.refresh='$refresh'
set system.$cfg.threshold='$threshold'
EOF
	UCIDEF_LEDS_CHANGED=1
