	MODE=$1
	SYSCFG_INDEX=$2
	RESTART=0
	FILENAME=/tmp/"$SYSCFG_INDEX"_"$MODE"_settings.conf
	CHANGED_FILE=/tmp/wifi_changed_settings.conf
	if [ ! -f $FILENAME ]; then
		create_files
		return 1
	fi
	INFO_NEEDED=`get_settings_list $MODE $SYSCFG_INDEX`
	if [ -f $FILENAME ]; then
		for FIELD in $INFO_NEEDED; do
			INFO=`syscfg_get ${FIELD}`
			FIELD_DATA="$FIELD":" $INFO"
			FROM_FILE=`cat ${FILENAME} | grep "^$FIELD:"`
			if [ "$FROM_FILE" != "$FIELD_DATA" ] ; then
				RESTART=1
				echo "$FIELD" >> $CHANGED_FILE
			fi
		done
		return $RESTART
	fi
