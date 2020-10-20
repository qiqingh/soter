	local name
	local sysfs
	config_get name $1 name
	config_get sysfs $1 sysfs
	[ "$name" = "$NAME" -o "$sysfs" = "$NAME" -a -e "/sys/class/leds/${sysfs}" ] && {
		[ "$ACTION" = "set" ] &&
			echo 1 >/sys/class/leds/${sysfs}/brightness \
			|| echo 0 >/sys/class/leds/${sysfs}/brightness
		exit 0
	}
