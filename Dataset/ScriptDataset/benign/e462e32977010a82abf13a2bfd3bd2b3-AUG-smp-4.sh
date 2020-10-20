	if [ $# -lt 2 ]; then
		dbg "gen_vifs_to_rps_if requires 2 parameters"
		return
	fi

	vif=$1
	total=$2
	#dbg "gen_vifs_to_rps_if $vif $total"
	i=0
	while [ "$i" -lt "$total" ]; do
		eval prefix=\$$vif
		eval $vif$i=$prefix$i

		RPS_IF_LIST="$RPS_IF_LIST $prefix$i"

		dbg2 "\$$vif$i=$prefix$i"

		i=`expr $i + 1`
	done
