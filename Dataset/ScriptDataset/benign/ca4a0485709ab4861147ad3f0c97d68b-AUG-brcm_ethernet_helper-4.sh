   et -i eth0 robowr 0x30 0x62 0xFA50
   et -i eth0 robowr 0x30 0x80 0x00
   et -i eth0 robowr 0x30 0x81 0x06
   et -i eth0 robowr 0x30 0x82 0x0C
   et -i eth0 robowr 0x30 0x83 0x18
   et -i eth0 robowr 0x30 0x84 0x30
   CURRENT=`et -i eth0 robord 0x30 0x00`
   HIGHBITS=`echo "$CURRENT" | awk '{print substr($0,3,2)}'`
   LOWBITS=`echo "$CURRENT" | awk '{print substr($0,6,1)}'`
   et -i eth0 robowr 0x30 0x00 0x${HIGHBITS}4${LOWBITS}
