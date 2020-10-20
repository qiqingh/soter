   ulog dhcpv6c status "in force_expire_deprecated_address $1 , $2"
   is_deprecated_delegated_address $1
   if [ "$?" = "1" ] ; then
      remove_deprecated_delegated_address $1
      sysevent set ipv6_firewall-restart
   else
      ulog dhcpv6c status "$2 is not currently on $1. Nothing to expire"
   fi
