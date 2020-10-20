	RADIO=$1
	INDEX=""
	IF=`radio_to_mrvl_physical_ifname $RADIO`
	INDEX=`echo $IF | cut -c 5`
	echo $INDEX
