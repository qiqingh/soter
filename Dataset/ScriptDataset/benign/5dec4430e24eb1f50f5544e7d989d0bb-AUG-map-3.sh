	local cfg="$1"
	ifdown "${cfg}_"
	rm -f /tmp/map-$cfg.rules
