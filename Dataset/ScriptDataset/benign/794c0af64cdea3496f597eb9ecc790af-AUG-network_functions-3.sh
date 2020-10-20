   if [ -z "$4" -o -z "$3" -o -z "$2" -o -z "$1" ] ; then
      return 0
   fi
   if [ "$2" -lt "$4" ] ; then
      TEST_NET_LEN=$2
   else
      TEST_NET_LEN=$4
   fi
   eval `ipcalc -n ${1}/${TEST_NET_LEN}`
   NET1=$NETWORK
   eval `ipcalc -n ${3}/${TEST_NET_LEN}`
   NET2=$NETWORK
   if [ "$NET1" = "$NET2" ] ; then
      return 1
   else
      return 0
   fi
