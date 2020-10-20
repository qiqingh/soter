	for MODE in physical virtual guest simpletap
	do
		SYSCFG_INDEX_LIST=`syscfg_get configurable_wl_ifs`
		for SYSCFG_INDEX in $SYSCFG_INDEX_LIST; do
			FILENAME=/tmp/"$SYSCFG_INDEX"_"$MODE"_settings.conf
			echo "wifi cache: saving $SYSCFG_INDEX $MODE settings"
			INFO_NEEDED=`get_settings_list $MODE $SYSCFG_INDEX`
			for FIELD in $INFO_NEEDED; do
				INFO=`syscfg_get ${FIELD}`
				FIELD_DATA="$FIELD":" $INFO"
				echo "$FIELD_DATA" >> $FILENAME
			done
		done
	done
