	PRIROOTFSMTD=`cat /proc/mtd | grep "rootfs" | grep -v "alt_" | cut -d':' -f1 | cut -f2 -d"d"`
	PRIROOTFSMTD2=`expr $PRIROOTFSMTD - 1`
	ALTROOTFSMTD=`cat /proc/mtd | grep "alt_rootfs" | cut -d':' -f1 | cut -f2 -d"d"`
	ALTROOTFSMTD2=`expr $ALTROOTFSMTD - 1`
	MOUNTEDMTD=`cat /proc/self/mountinfo | grep "\/dev\/root" | cut -f3 -d' ' | cut -f2 -d':'`
	if [ "$MOUNTEDMTD" == "0" ]; then 
		MOUNTEDMTD=`cat /sys/class/ubi/ubi0_0/device/mtd_num`
	fi
	
	IS_ALT=`cat /proc/mtd | grep mtd${MOUNTEDMTD} | grep "alt_"`
	
	if [ "$IS_ALT" ] ; then
		return 1
	else
		return 0
	fi
