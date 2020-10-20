	MODE=$1
	SYSCFG_INDEX=$2
	INFO_NEEDED=""
	if [ "wl0" = "$SYSCFG_INDEX" ]; then
		if [ "physical" = "$MODE" ]; then
			INFO_NEEDED=$WL0_PHYSICAL
		elif [ "virtual" = "$MODE" ]; then
			INFO_NEEDED=$WL0_VIRTUAL
		elif [ "guest" = "$MODE" ]; then
			INFO_NEEDED=$WL0_GUEST
		elif [ "simpletap" = "$MODE" ]; then
			INFO_NEEDED=$WL0_SIMPLETAP
		fi
	elif [ "wl1" = "$SYSCFG_INDEX" ]; then
		if [ "physical" = "$MODE" ]; then
			INFO_NEEDED=$WL1_PHYSICAL
		elif [ "virtual" = "$MODE" ]; then
			INFO_NEEDED=$WL1_VIRTUAL
		elif [ "guest" = "$MODE" ]; then
			INFO_NEEDED=$WL1_GUEST
		elif [ "simpletap" = "$MODE" ]; then
			INFO_NEEDED=$WL1_SIMPLETAP
		fi
	fi
	echo "$INFO_NEEDED"
