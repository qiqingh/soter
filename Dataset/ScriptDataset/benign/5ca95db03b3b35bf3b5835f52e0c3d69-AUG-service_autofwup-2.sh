	FIRMWARE_PART_1=`syscfg get fwup_part_1`
	FIRMWARE_PART_2=`syscfg get fwup_part_2`
	Debug "Checking dual partition update: $FORCED_UPDATE"
	Debug "part1: $FIRMWARE_PART_1"
	Debug "part2: $FIRMWARE_PART_2"
	if [ "$FORCED_UPDATE" == "$FIRMWARE_PART_1" ] && [ "$FORCED_UPDATE" == "$FIRMWARE_PART_2" ]; then
		Debug "Forced Update Done"
		PartitionUpdated=2
	fi
