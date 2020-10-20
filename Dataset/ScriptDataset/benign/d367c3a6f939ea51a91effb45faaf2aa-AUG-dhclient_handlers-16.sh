   PREPARE=0
   if [ -z "`sysevent get ipv6_nameserver`" ] ; then 
      if [ -n "$new_dhcp6_name_servers" ] ; then
         ulog dhcpv6c status "renew_dns_info: Provisioning $interface nameservers with $new_dhcp6_name_servers"
         sysevent set ipv6_nameserver "${new_dhcp6_name_servers}"
         PREPARE=1
      fi
   fi
   if [ -z "`sysevent get ipv6_domain`" ] ; then 
      if [ -n "$new_dhcp6_domain_search" ] ; then
         ulog dhcpv6c status "renew_dns_info: Provisioning $interface search order with $new_dhcp6_domain_search"
         sysevent set ipv6_domain "$new_dhcp6_domain_search"
         PREPARE=1
      fi
   fi
   if [ -n "$new_ip6_prefix" ] ; then 
      sysevent set dhcpv6_dns_info_owner $new_ip6_prefix
   fi
   if [ "1" = "$PREPARE" ] ; then
      prepare_resolver_conf
   fi
