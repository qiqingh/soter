	RADIO=$1
	INDEX=""
	IF=`radio_to_brcm_physical_ifname $RADIO`
	TOKEN=`nvram get wl0_ifname | awk -F"=" '{print $1}'`
	if [ "`echo $IF | tr [:upper:] [:lower:]`" = "`echo $TOKEN | tr [:upper:] [:lower:]`" ]; then
		INDEX=0
	else
		INDEX=1
	fi
	echo $INDEX
