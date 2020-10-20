	local subnets=$1
	local res
	local res_mask

	for subnet in $subnets; do
		local addr="${subnet%%/*}"
		local mask="${subnet#*/}"

		if [ -n "$res_mask" -a "$mask" != 32 ]; then
			[ "$mask" -gt "$res_mask" ] || [ "$res_mask" = 32 ] && {
				res="$addr"
				res_mask="$mask"
			}
		elif [ -z "$res_mask" ]; then
			res="$addr"
			res_mask="$mask"
		fi
	done

	echo "$res"
