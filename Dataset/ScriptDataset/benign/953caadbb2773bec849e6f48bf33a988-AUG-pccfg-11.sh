	COUNT=`syscfg get parental_control_policy_count`
	
	for policy in `seq 1 $COUNT`; do
		get $policy
		echo
	done
