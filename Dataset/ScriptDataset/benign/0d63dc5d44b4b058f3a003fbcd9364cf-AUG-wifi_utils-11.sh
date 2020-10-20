	MODE=$1
	WL_LIST=$2
	if [ "physical" != "$MODE" ] && [ "virtual" != "$MODE" ] ; then
		echo "Fatal error, the settings will not be saved" > /dev/console
		return 0
	fi
	FILENAME=/tmp/wifi_"$MODE"_settings.conf
	if [ ! -f $FILENAME ]; then
		create_files
		return
	fi
	if [ "physical" = "$MODE" ]; then
		INFO_NEEDED=$PHYSICAL_SETTINGS
	elif [ "virtual" = "$MODE" ]; then
		INFO_NEEDED=$VIRTUAL_SETTINGS
		WL_LIST=`syscfg get configurable_wl_ifs`
	fi
	for WL in $WL_LIST
	do
		for FIELD in $INFO_NEEDED
		do
			VARIABLE="$WL"_"$FIELD"
			for TEMP in $NOT_INTERFACE_SPECIFIC; do
				if [ "$FIELD" = "$TEMP" ]; then
					VARIABLE="$FIELD"
					break;
				fi
			done
			INFO=`syscfg get ${VARIABLE}`
			FIELD_DATA="$VARIABLE":" $INFO"
			sed -i 's/'"$VARIABLE"':.*/'"$FIELD_DATA"'/g' $FILENAME
		done
	done
