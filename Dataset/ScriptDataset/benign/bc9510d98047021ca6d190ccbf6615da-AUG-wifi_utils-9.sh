	MODE=$1
	WL=$2
	RESTART=0
	FILENAME=/tmp/wifi_"$MODE"_settings.conf
	CHANGED_FILE=/tmp/wifi_changed_settings.conf
	if [ ! -f $FILENAME ]; then
		create_files
		return 1
	fi
	if [ "physical" = "$MODE" ]; then
		INFO_NEEDED=$PHYSICAL_SETTINGS
	elif [	"virtual" = "$MODE" ]; then
		INFO_NEEDED=$VIRTUAL_SETTINGS
	fi
	if [ -f $FILENAME ]; then
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
			FROM_FILE=`cat ${FILENAME} | grep ${VARIABLE} -m 1`
			if [ "$FROM_FILE" != "$FIELD_DATA" ] ; then
				RESTART=1
				echo "$VARIABLE" >> $CHANGED_FILE
			fi
		done
		
		echo "restart_required(MODE=$MODE, WL=$WL) returns $RESTART" > /dev/null
		return $RESTART
	fi
