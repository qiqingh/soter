	config_load system
	config_foreach migrate_led_sysfs led "$@"
