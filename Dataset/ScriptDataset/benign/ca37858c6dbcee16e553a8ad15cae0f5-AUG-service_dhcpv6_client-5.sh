   if [ ! -s /var/run/dhcpv6c_duid ] 
   then
        SYSCFG_dhcpv6c_duid=`syscfg get dhcpv6c_duid`
	if [ -z "$SYSCFG_dhcpv6c_duid" ] 
        then
           ulog dhcpv6c status "No dhcpv6 client duid exists. Creating one ..."
           make_dhcpv6c_duid dhcpv6c_duid
           SYSCFG_dhcpv6c_duid=`syscfg get dhcpv6c_duid`
         fi
         echo -n "$SYSCFG_dhcpv6c_duid" > /var/run/dhcp6c_duid
   fi
