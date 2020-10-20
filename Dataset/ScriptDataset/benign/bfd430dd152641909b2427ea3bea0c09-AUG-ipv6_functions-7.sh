   if [ -z "$1" ] ; then
      return 0
   fi
   if [ -n "$2" ] ; then
      PREFIX="`echo $2 | cut -d '/' -f1`/64"
   else
      PREFIX=
   fi
   NOW=`date +%s`
   CURRENT_PREFIX=`sysevent get ${1}_ipv6_prefix`
   CURRENT_VALID=`sysevent get ${1}_ipv6_prefix_valid_lifetime`
   CURRENT_PREFERRED=`sysevent get ${1}_ipv6_prefix_preferred_lifetime`
   if [ "$CURRENT_PREFIX" = "$PREFIX" -a "$CURRENT_VALID" = "$3" -a "$CURRENT_PREFERRED" = "$4" ] ; then
      sysevent set ${1}_ipv6_prefix_acquired_time $NOW
   else
      if [ "$PREFIX" != "$CURRENT_PREFIX" ] ; then
         deprecate_lan_ipv6_prefix $1
         IPV6_FIREWALL_RESTART=needed
      fi
      sysevent set ${1}_ipv6_prefix $PREFIX
      if [ -n "$PREFIX" ] ; then
         sysevent set ${1}_ipv6_prefix_valid_lifetime $3
         sysevent set ${1}_ipv6_prefix_preferred_lifetime $4
         sysevent set ${1}_ipv6_prefix_acquired_time $NOW
      else
         sysevent set ${1}_ipv6_prefix_valid_lifetime
         sysevent set ${1}_ipv6_prefix_preferred_lifetime
         sysevent set ${1}_ipv6_prefix_acquired_time
      fi
   fi
