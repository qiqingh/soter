	POLICY=1
	preset1 $POLICY
	syscfg set parental_control_policy_$POLICY pcp_$POLICY

	POLICY=2
	preset2 $POLICY
	syscfg set parental_control_policy_$POLICY pcp_$POLICY
	
	syscfg_set parental_control_policy_count $POLICY
