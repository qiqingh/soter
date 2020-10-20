	if [ "`syscfg_get ${SERVICE_NAME}_debug`" = "1" ]; then
		set +x
	fi
	MODE=$1
	SYSCFG_INDEX_LIST=`syscfg_get configurable_wl_ifs`
	if [ "physical" != "$MODE" ] && [ "virtual" != "$MODE" ] && [ "guest" != "$MODE" ] ; then
		echo "Fatal error, the settings will not be saved" > /dev/console
		if [ "`syscfg_get ${SERVICE_NAME}_debug`" = "1" ]; then
			set -x
		fi
		return 1
	fi
	SYSCFG_INDEX_LIST=`syscfg_get configurable_wl_ifs`
	for SYSCFG_INDEX in $SYSCFG_INDEX_LIST; do
		FILENAME=/tmp/"$SYSCFG_INDEX"_"$MODE"_settings.conf
		ulog wlan status "${SERVICE_NAME}, cache: updating $SYSCFG_INDEX $MODE settings"
		INFO_NEEDED=`get_settings_list $MODE $SYSCFG_INDEX`
		for FIELD in $INFO_NEEDED; do
			INFO=`syscfg_get ${FIELD}`
			FIELD_DATA="$FIELD":" $INFO"
			sed -i 's/'"$FIELD"':.*/'"$FIELD_DATA"'/g' $FILENAME
		done
	done
	if [ "`syscfg_get ${SERVICE_NAME}_debug`" = "1" ]; then
		set -x
	fi
	return 0
