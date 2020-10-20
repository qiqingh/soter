	for MODE in physical virtual
	do
		FILENAME=/tmp/wifi_"$MODE"_settings.conf
		if [ "physical" = "$MODE" ]; then
			INFO_NEEDED=$PHYSICAL_SETTINGS
		elif [ "virtual" = "$MODE" ]; then
			INFO_NEEDED=$VIRTUAL_SETTINGS
		fi
		for WL in wl0 wl1; do
			for FIELD in $INFO_NEEDED; do
				VARIABLE="$WL"_"$FIELD"
				for TEMP in $NOT_INTERFACE_SPECIFIC; do
					if [ "$FIELD" = "$TEMP" ]; then
						VARIABLE="$FIELD"
						break;
					fi
				done
				INFO=`syscfg get ${VARIABLE}`
				FIELD_DATA="$VARIABLE":" $INFO"
				echo "$FIELD_DATA" >> $FILENAME
			done
		done
	done
