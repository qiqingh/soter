   if [ -z "$1" -o -z "$2" ] ; then
      return 254
   fi
   for i in $(seq 5); do
      sleep 1
      IPV6_FUNCTS_DAD_FAILED=`ip -6 addr show dev $1 dadfailed | grep $2`
      if [ -n "$IPV6_FUNCTS_DAD_FAILED" ] ; then
         return 255
         break
      fi
   done
   
   return 0
