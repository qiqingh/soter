   if [ -n "$new_dhcp6_name_servers" ] ; then
      ulog dhcpv6c status "new_dns_info: Provisioning $interface nameservers with $new_dhcp6_name_servers"
      sysevent set ipv6_nameserver "${new_dhcp6_name_servers}"
   fi
   if [ -n "$new_dhcp6_domain_search" ] ; then
      ulog dhcpv6c status "new_dns_info: Provisioning $interface search order with $new_dhcp6_domain_search"
      sysevent set ipv6_domain "$new_dhcp6_domain_search"
   fi
   sysevent set dhcpv6_dns_info_owner $new_ip6_prefix
   prepare_resolver_conf
