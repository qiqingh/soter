   if [ -z "$1" -o -z "$2" ] ; then
      return 0
   fi
   sysevent set ${1}_ipv6_deprecated_but_valid_delegated_address  $2
