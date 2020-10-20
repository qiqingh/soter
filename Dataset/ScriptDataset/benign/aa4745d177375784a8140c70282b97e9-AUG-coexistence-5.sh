	local result=$(cat /sys/class/gpio/gpio43/value)

	if [ "X$result" = "X1" ]; then
		echo "WIFI Deny"
	elif [ "X$result" = "X0" ]; then
		echo "WIFI activatable"
	else
		echo "WIFI Unknown"
	fi
