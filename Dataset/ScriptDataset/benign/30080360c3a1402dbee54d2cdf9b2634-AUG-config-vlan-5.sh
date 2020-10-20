	mii_mgr -s -p 20 -r  4 -v 0xa000
	mii_mgr -s -p 20 -r 13 -v 0x21
	mii_mgr -s -p 21 -r  1 -v 0x1800
	mii_mgr -s -p 22 -r  0 -v 0x27ff
	mii_mgr -s -p 22 -r  2 -v 0x20
	mii_mgr -s -p 22 -r  3 -v 0x8100
	mii_mgr -s -p 22 -r 10 -v 0x3
	mii_mgr -s -p 22 -r 14 -v 0x1001
	mii_mgr -s -p 22 -r 15 -v 0x2002
	mii_mgr -s -p 23 -r  8 -v 0x2020
	mii_mgr -s -p 23 -r 16 -v 0x1f1f
	if [ "$1" = "LLLLW" ]; then
		mii_mgr -s -p 22 -r 4 -v 0x1
		mii_mgr -s -p 22 -r 5 -v 0x1
		mii_mgr -s -p 22 -r 6 -v 0x1
		mii_mgr -s -p 22 -r 7 -v 0x1
		mii_mgr -s -p 22 -r 8 -v 0x2
		mii_mgr -s -p 23 -r 0 -v 0x302f
	elif [ "$1" = "WLLLL" ]; then
		mii_mgr -s -p 22 -r 4 -v 0x2
		mii_mgr -s -p 22 -r 5 -v 0x1
		mii_mgr -s -p 22 -r 6 -v 0x1
		mii_mgr -s -p 22 -r 7 -v 0x1
		mii_mgr -s -p 22 -r 8 -v 0x1
		mii_mgr -s -p 23 -r 0 -v 0x213e
	else
		echo "LAN WAN layout $0 is not suported"
	fi
