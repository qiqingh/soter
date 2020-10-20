   if [ -z "$1" ] ; then
      return 255
   else
      interface_info_by_namespace $1
      RET=$?
      if [ 0 != "$RET" ] ; then
         return $RET
      fi
   fi
   NAMESPACE=$1
   return 0
