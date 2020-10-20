   CURRENT=`et -i eth0 robord 0x34 0x00`
   HIGHBITS=`echo "$CURRENT" | awk '{print substr($0,3,2)}'`
   LOWBITS=`echo "$CURRENT" | awk '{print substr($0,6,1)}'`
   et -i eth0 robowr 0x34 0x00 0x${HIGHBITS}0${LOWBITS}
