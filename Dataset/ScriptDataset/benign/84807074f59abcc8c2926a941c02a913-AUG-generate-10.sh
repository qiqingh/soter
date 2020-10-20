	local C="$1"
	for iface in $INTERFACES; do
		start_interface "$iface" "$C"
	done
