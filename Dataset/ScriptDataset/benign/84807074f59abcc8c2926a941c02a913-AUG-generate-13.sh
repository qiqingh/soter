	add_insmod xt_multiport
	add_insmod xt_CONNMARK
	stop_firewall
	for group in $CG; do
		start_cg $group
	done
