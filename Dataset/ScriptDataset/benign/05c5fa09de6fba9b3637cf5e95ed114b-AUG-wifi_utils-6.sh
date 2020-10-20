	IS_MAC_ADMIN=$1
	BASE_PHY_MACADDR=$2
	INCREMENT=$3
	if [ "$IS_MAC_ADMIN" = "true" ] || [ "$IS_MAC_ADMIN" = "TRUE" ]; then
		FIRST_BYTE=`echo $BASE_PHY_MACADDR | awk -F":" '{print $1}'`
		MIDDLE_BYTES=`echo $BASE_PHY_MACADDR | awk -F":" '{print $2":"$3":"$4":"$5}'`
		LAST_BYTE=`echo $BASE_PHY_MACADDR | awk -F":" '{print $6}'`
		LAST_BYTE_HEX=`printf '%d' "0x"$LAST_BYTE`
		MAC_ADMIN_LOCAL=`printf '%d' "0x"$FIRST_BYTE`
		MAC_ADMIN_LOCAL=`awk -v value=$MAC_ADMIN_LOCAL 'BEGIN{ s=or(2,value);print s}'`
		MAC_ADMIN_LOCAL=`printf '%02x\n' $MAC_ADMIN_LOCAL`
		MAC_ADMIN_LOCAL=`echo $MAC_ADMIN_LOCAL | tr '[a-z]' '[A-Z]'`
		BYTE_CHECK=`expr $LAST_BYTE_HEX % 16` # 63 % 16 = 15  
		if [ "$BYTE_CHECK" = "15" ]; then
			LAST_BYTE_INC=`expr $LAST_BYTE_HEX / 16` # 63 / 16 = 3
			LAST_BYTE_INC=`expr $LAST_BYTE_INC \* 16` # 3 * 16 = 48  
		else	
			LAST_BYTE_INC=`expr $LAST_BYTE_HEX + $INCREMENT`
		fi	
		LAST_BYTE_INC_HEX=`printf '%02x\n' $LAST_BYTE_INC`
		LAST_BYTE_INC_HEX=`echo $LAST_BYTE_INC_HEX | tr '[a-z]' '[A-Z]'`
		newMAC="$MAC_ADMIN_LOCAL"":$MIDDLE_BYTES"":$LAST_BYTE_INC_HEX"
	else
		newMAC=`incr_mac "$BASE_PHY_MACADDR" "$INCREMENT"`
		newMAC=`echo $newMAC | tr '[a-z]' '[A-Z]'`
	fi
	echo "$newMAC"
