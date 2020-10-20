	if [ "$1" = "LLLLW" ]; then
		#VLAN member port
		switch vlan  set 1 1 11110011
		switch vlan  set 2 2 00001100
		#set PVID
		#switch pvid 4 2
		#switch pvid 5 2
		#LAN/WAN ports as security mode
		switch reg w 2004 ff0003 #port0
		switch reg w 2104 ff0003 #port1
		switch reg w 2204 ff0003 #port2
		switch reg w 2304 ff0003 #port3
		switch reg w 2404 ff0003 #port4
		switch reg w 2504 ff0003 #port5
		switch reg w 2604 ff0003 #port6
	elif [ "$1" = "WLLLL" ]; then
		#VLAN member port
		switch vlan  set 1 1 01111011
		switch vlan  set 2 2 10000100
		#set PVID
		#switch pvid 0 2
		#switch pvid 5 2
		#LAN/WAN ports as security mode
		switch reg w 2004 ff0003 #port0
		switch reg w 2104 ff0003 #port1
		switch reg w 2204 ff0003 #port2
		switch reg w 2304 ff0003 #port3
		switch reg w 2404 ff0003 #port4
		switch reg w 2504 ff0003 #port5
		switch reg w 2604 ff0003 #port6
	fi
