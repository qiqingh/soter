   if [ -z "$1" ] ; then
      INT_NAME="`syscfg get lan_ifname`"
   else
      INT_NAME="$1"
   fi
   MAC_LINE=`ip  addr show dev $INT_NAME | grep link`
   MAC=`echo $MAC_LINE | cut -d" " -f 2`
   for i in 1 2 3 4 5 6
   do
      eval "PART_${i}=`echo $MAC |  cut -d ':' -f ${i}`"
   done
   EUI_64="${PART_1}${PART_2}:${PART_3}ff:fe${PART_4}:${PART_5}${PART_6}"
   eval `ip6calc -x ${EUI_64}:: 0200::`
   eval `ip6calc -r $XOR 64`
   EUI_64=${SHIFT:2:20} 
   
