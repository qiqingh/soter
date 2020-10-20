    if [ "$1" = "3" -a "$2" = "LLLLW" ]; then
        config6855Esw LLLLW
    elif [ "$1" = "3" -a "$2" = "0" ]; then
        restore6855Esw
    elif [ "$1" = "4" -a "$2" = "0" ]; then
        restore7530Esw
    elif [ "$1" = "3" -a "$2" = "WLLLL" ]; then
        #restore6855Esw
	#switch vlan clear
	switch vlan  set 1 1 01111011
	switch vlan  set 2 2 10000100
	switch vlan pvid 0 2
	switch vlan pvid 5 2
	switch reg w 2004 ff0003
	switch reg w 2104 ff0003
	switch reg w 2204 ff0003
	switch reg w 2304 ff0003
	switch reg w 2404 ff0003
	switch reg w 2504 ff0003
	switch reg w 2604 ff0003
    elif [ "$1" = "5" -a "$2" = "LLLLW" ]; then
	#MT7531 usage: use p0~p3 as lan_port, and p4 as wan_port, but it is not be used.
	#lan port: p0~p3
	#wan port: p4		//not need ??
	#cpu port: p6
	switch vlan  set 1 1 11110011
	switch vlan  set 2 2 00001010
	switch vlan pvid 4 2
	switch vlan pvid 5 2
	switch reg w 2004 ff0003 #port0 set as security mode
	switch reg w 2104 ff0003 #port1 set as security mode
	switch reg w 2204 ff0003 #port2 set as security mode
	switch reg w 2304 ff0003
	switch reg w 2404 ff0003
	switch reg w 2504 ff0003
	switch reg w 2604 ff0003
	#switch reg w 2704 ff0003	#do we need it ??
    else
        echo "unknown swith/VLAN type $1/$2"
        echo ""
        usage $0
    fi
