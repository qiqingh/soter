	POLICY=$1

	echo -n "generating policy $POLICY..."

	value "number" $POLICY 1
	value "name" $POLICY "Access Policy 1"
	value "status" $POLICY "Enabled"
	value "safe_surfing" $POLICY 0
	category $POLICY
	schedule "monday_time_blocks" $POLICY
	schedule "tuesday_time_blocks" $POLICY
	schedule "wednesday_time_blocks" $POLICY
	schedule "thursday_time_blocks" $POLICY
	schedule "friday_time_blocks" $POLICY
	schedule "saturday_time_blocks" $POLICY
	schedule "sunday_time_blocks" $POLICY
	devicelist $POLICY
	blocklist $POLICY
	whitelist $POLICY

	echo "done"
