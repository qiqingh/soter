	if [ "$(sysevent get fwup_checked_after_boot)" == 0 ]; then
		cron_event
	fi	
