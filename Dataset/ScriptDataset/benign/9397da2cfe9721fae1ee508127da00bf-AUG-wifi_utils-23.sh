	PHY_IF=$1
	MAC=`ifconfig $PHY_IF | grep HWaddr | awk '{print $5}'`
	echo "$MAC"
