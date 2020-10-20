   if [ -z "$1" ] ; then
      return 0
   fi
   sysevent set previous_${1}_ipv6_prefix
   sysevent set previous_${1}_ipv6_prefix_valid_lifetime
   sysevent set previous_${1}_ipv6_prefix_preferred_lifetime
   sysevent set previous_${1}_ipv6_prefix_acquired_time
