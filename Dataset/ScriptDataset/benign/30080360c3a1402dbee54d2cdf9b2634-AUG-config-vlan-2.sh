	mii_mgr -s -p 29 -r 23 -v 0x07c2
	mii_mgr -s -p 29 -r 22 -v 0x8420

	if [ "$1" = "LLLLW" ]; then
		mii_mgr -s -p 29 -r 24 -v 0x1
		mii_mgr -s -p 29 -r 25 -v 0x1
		mii_mgr -s -p 29 -r 26 -v 0x1
		mii_mgr -s -p 29 -r 27 -v 0x1
		mii_mgr -s -p 29 -r 28 -v 0x2
		mii_mgr -s -p 30 -r 9 -v 0x1089
		if [ "$CONFIG_RALINK_VISTA_BASIC" == "y" ]; then
			mii_mgr -s -p 30 -r 1 -v 0x2f3f
		else
			mii_mgr -s -p 30 -r 1 -v 0x2f00
		fi
		mii_mgr -s -p 30 -r 2 -v 0x0030
	elif [ "$1" = "WLLLL" ]; then
		mii_mgr -s -p 29 -r 24 -v 0x2
		mii_mgr -s -p 29 -r 25 -v 0x1
		mii_mgr -s -p 29 -r 26 -v 0x1
		mii_mgr -s -p 29 -r 27 -v 0x1
		mii_mgr -s -p 29 -r 28 -v 0x1
		mii_mgr -s -p 30 -r 9 -v 0x0189
		if [ "$CONFIG_RALINK_VISTA_BASIC" == "y" ]; then
			mii_mgr -s -p 30 -r 1 -v 0x3e3f
		else
			mii_mgr -s -p 30 -r 1 -v 0x3e00
		fi
		mii_mgr -s -p 30 -r 2 -v 0x0021
	else
		echo "LAN WAN layout $0 is not suported"
	fi
