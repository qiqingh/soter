   OWNER=`sysevent get dhcpv6_dns_info_owner`
   if [ -n "$OWNER" -a -n "$old_ip6_prefix" -a "$OWNER" != "$old_ip6_prefix" ] ; then
      ulog dhcpv6c status "release_dns_info: requester is not data owner ( $old_ip6_prefix ,$OWNER ). Ignoring release"
      return 0
   else
      sysevent set dhcpv6_dns_info_owner
   fi
   NEED_PREPARE_RESOLV_CONF=0
   if [ -n "$old_dhcp6_name_servers" ] ; then
      T_FILE_1=/tmp/dhcpv6_${$}_temp1_nameserver
      DNS_SERVERS=`sysevent get ipv6_nameserver`
      echo "$DNS_SERVERS" > $T_FILE_1
      for loop in $old_dhcp6_name_servers
      do
         ulog dhcpv6c status "release_dns_info: releasing $loop as nameserver."
         sed -i "/$loop/d" $T_FILE_1
      done
   fi
   if [ -n "$old_dhcp6_domain_search" ] ; then
      T_FILE_2=/tmp/dhcpv6_${$}_temp2_nameserver
      DNS_SEARCH=`sysevent get ipv6_domain`
      echo "$DNS_SEARCH" > $T_FILE_2
      for loop in $old_dhcp6_domain_search
      do
         ulog dhcpv6c status "release_dns_info: releasing $loop as domain."
         sed -i "/$loop/d" $T_FILE_2
      done
   fi
   if [ -f "$T_FILE_1" ] ; then
      sysevent set ipv6_nameserver `cat $T_FILE_1`
      rm -f $T_FILE_1
      NEED_PREPARE_RESOLV_CONF=1
   fi
   if [ -f "$T_FILE_2" ] ; then
      sysevent set ipv6_domain `cat $T_FILE_2`
      rm -f $T_FILE_2
      NEED_PREPARE_RESOLV_CONF=1
   fi
   if [ "1" = "$NEED_PREPARE_RESOLV_CONF" ] ; then
      prepare_resolver_conf
   fi
