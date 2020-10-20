   if [ -z "$1" ] ; then
      return 0
   fi
   cur=`sysevent get ${1}_ipv6_deprecated_but_valid_delegated_address`
   
   if [ -n "$cur" ] ; then
      return 1
   fi
   return 0
