	MFG_MODE=$(gcontrol uenv get ManufactureMode | awk -F"=" '{print $2}')

	[ "$MFG_MODE" = "" -o "$MFG_MODE" = "0" ] && {
		# 2.4G
		echo "Wireless Normal Mode" > /dev/console

		# 5G
	}

	[ "$MFG_MODE" = "1" ] && {

		echo "Wireless Manufcture Mode" > /dev/console
		# 2.4G
		wificonf -f $PATH_24G set HT_BSSCoexistence 0
		# 5G
	}

	[ "$MFG_MODE" = "2" ] && {
		echo "Wireless Golden Mode" > /dev/console
	}

