   if [ -z "$1" ] ; then
      return 0
   fi
   CURRENT_PREFIX=`sysevent get ${1}_ipv6_prefix`
   CURRENT_VALID=`sysevent get ${1}_ipv6_prefix_valid_lifetime`
   CURRENT_PREFERRED=`sysevent get ${1}_ipv6_prefix_preferred_lifetime`
   if [ -n "$CURRENT_PREFIX" ] ; then
      REMAINING_TIME=0
      NOW=`date +%s`
      THEN=`sysevent get ${1}_ipv6_prefix_acquired_time`
      if [ -n "$NOW" -a -n "$THEN" ] ; then
         REMAINING_TIME=`expr $NOW - $THEN`
         REMAINING_TIME=`expr $CURRENT_VALID - $REMAINING_TIME`
         if [ "5" -lt "$REMAINING_TIME" ] ; then
            REMAINING_TIME=5
         fi
         sysevent set previous_${1}_ipv6_prefix                    $CURRENT_PREFIX 
         sysevent set previous_${1}_ipv6_prefix_valid_lifetime     $REMAINING_TIME
         sysevent set previous_${1}_ipv6_prefix_preferred_lifetime 0
         sysevent set previous_${1}_ipv6_prefix_acquired_time $NOW
      fi
      sysevent set ${1}_ipv6_prefix
      sysevent set ${1}_ipv6_prefix_valid_lifetime 0
      sysevent set ${1}_ipv6_prefix_preferred_lifetime 0
      sysevent set ${1}_ipv6_prefix_acquired_time
   fi
