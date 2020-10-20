	PRIROOTFSMTD=`cat /proc/mtd | grep "rootfs" | grep -v "alt_" | cut -d':' -f1 | cut -f2 -d"d"`
	PRIROOTFSMTD2=`expr $PRIROOTFSMTD - 1`
	ALTROOTFSMTD=`cat /proc/mtd | grep "alt_rootfs" | cut -d':' -f1 | cut -f2 -d"d"`
	ALTROOTFSMTD2=`expr $ALTROOTFSMTD - 1`
	MOUNTEDMTD=`cat /proc/self/mountinfo | grep "\/dev\/root" | cut -f3 -d' ' | cut -f2 -d':'`
	
	IS_ALT=`cat /proc/mtd | grep mtd${MOUNTEDMTD} | grep "alt_"`
	
	if [ "$IS_ALT" ] ; then
		return 1
	else
		return 0
	fi
	
	if [ "$MOUNTEDMTD" -eq "$PRIROOTFSMTD" ] || [ "$MOUNTEDMTD" -eq "$PRIROOTFSMTD2" ]
	then
		return 0	
	fi
	if [ "$MOUNTEDMTD" -eq "$ALTROOTFSMTD" ] || [ "$MOUNTEDMTD" -eq "$ALTROOTFSMTD2" ]
	then
		return 1	
	fi
	return 255 
