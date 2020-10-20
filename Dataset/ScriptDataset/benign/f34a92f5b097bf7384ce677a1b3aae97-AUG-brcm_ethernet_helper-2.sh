   CURRENT=`et robord 0x34 0x00`
   HIGHBITS=`echo "$CURRENT" | awk '{print substr($0,3,2)}'`
   LOWBITS=`echo "$CURRENT" | awk '{print substr($0,6,1)}'`
   et robowr 0x34 0x00 0x${HIGHBITS}e${LOWBITS}
