    [ -d /sys/class/neta-switch ] && lan_ports=/sys/class/neta-switch/port[0123]/power
    [ -n "$lan_ports" ] && {
	for i in $lan_ports; do
	    echo 0 > $i
	done
    }
