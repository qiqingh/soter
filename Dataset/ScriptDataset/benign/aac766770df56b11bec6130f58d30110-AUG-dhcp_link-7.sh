   BYTE3=0x`ip link show $interface | grep link | awk '{print $2}' | awk 'BEGIN { FS = ":" } ; { printf ("%s", $6) }'`
   BYTE3=`echo $BYTE3 | awk ' {printf ("%d", $1)}'`
   
   BYTE2=0x`ip link show $interface | grep link | awk '{print $2}' | awk 'BEGIN { FS = ":" } ; { printf ("%s", $5) }'`
   BYTE2=`echo $BYTE2 | awk ' {printf ("%d", $1)}'`
 
   RANDOM=`expr $BYTE3 \* $BYTE2`
   OCTET3=`expr $RANDOM % 256`
   RANDOM=`expr $RANDOM - $BYTE3`
   OCTET4=`expr $RANDOM % 255`
   if [ "0" -eq $OCTET4 ] ; then
      OCTET4=65
   fi
   /sbin/ip -4 addr add 169.254.$OCTET3.$OCTET4/255.255.0.0 dev $interface
   /sbin/ip -4 link set dev $interface up
