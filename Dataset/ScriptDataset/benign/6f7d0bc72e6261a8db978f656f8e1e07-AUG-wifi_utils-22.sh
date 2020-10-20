	for PHY_IF in $PHYSICAL_IF_LIST; do
		SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
   		PWRFILE=`syscfg_get ${SYSCFG_INDEX}_power_table`
		if [ -n "$PWRFILE" ] && [ -s "$PWRFILE" ] ; then
			echo "wifi, no power tables yet"
		else
			ERROR="${SERVICE_NAME}, Error! Missing $PWRFILE"
			ulog wlan status $ERROR > /dev/console
		fi
	done
	return 0
