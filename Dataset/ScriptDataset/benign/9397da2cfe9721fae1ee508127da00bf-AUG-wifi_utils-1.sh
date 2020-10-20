	if [ "`syscfg_get ${SERVICE_NAME}_debug`" = "1" ]; then
		set +x
	fi
	MODE=$1
	SYSCFG_INDEX=$2
	RESTART=0
	PHY_INF=`get_phy_interface_name_from_syscfg $SYSCFG_INDEX`
	if [ "physical" = "$MODE" ]; then
		if [ "2" = "`syscfg_get wifi_bridge::mode`" ] && [ "$PHY_INF" = "`syscfg_get wifi_sta_phy_if`" ]; then
			echo "restart_required: $PHY_INF is repeater, do not restart physical interface"
			return 0
		fi
	fi
	FILENAME=/tmp/"$SYSCFG_INDEX"_"$MODE"_settings.conf
	if [ ! -f $FILENAME ]; then
		create_files
		RESTART=1
	else
		INFO_NEEDED=`get_settings_list $MODE $SYSCFG_INDEX`
		for FIELD in $INFO_NEEDED; do
			INFO=`syscfg_get ${FIELD}`
			FIELD_DATA="$FIELD":" $INFO"
			FROM_FILE=`cat ${FILENAME} | grep "^$FIELD:"`
			if [ "$FROM_FILE" != "$FIELD_DATA" ] ; then
				RESTART=1
				echo "$FIELD" >> $CHANGED_FILE
			fi
		done
	fi
	if [ "`syscfg_get ${SERVICE_NAME}_debug`" = "1" ]; then
		set -x
	fi
	return $RESTART
