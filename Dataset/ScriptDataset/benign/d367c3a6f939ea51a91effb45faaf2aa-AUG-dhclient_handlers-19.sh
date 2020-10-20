      if [ -n "`sysevent get dhcpv6_aftr`" ] ; then
         ulog dhcpv6c status "release_aftr: Unprovisioning dhcpv6 acquired aftr"
         sysevent set dhcpv6_aftr
      fi
