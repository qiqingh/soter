	PRIROOTFSMTD=`cat /proc/mtd | grep "rootfs" | grep -v "alt_" | cut -d':' -f1 | cut -f2 -d"d"`
	ALTROOTFSMTD=`cat /proc/mtd | grep "alt_rootfs" | cut -d':' -f1 | cut -f2 -d"d"`
	MOUNTEDMTD=`cat /proc/self/mountinfo | grep "\/dev\/root" | cut -f3 -d' ' | cut -f2 -d':'`
	if [ "$MOUNTEDMTD" -eq "$PRIROOTFSMTD" ]
	then
		return 0	
	fi
	if [ "$MOUNTEDMTD" -eq "$ALTROOTFSMTD" ]
	then
		return 1	
	fi
	return 255 
