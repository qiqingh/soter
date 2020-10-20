	IF=$1
	CHIPNUM=""
	CHIPNUM=`wl -i $IF revinfo | grep deviceid | sed 's/deviceid 0x//g'`
	echo $CHIPNUM
