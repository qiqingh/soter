   if [ ! -s /var/run/dhcp6s_duid ] 
   then
	if [ -z "$SYSCFG_dhcpv6s_duid" ] 
        then
           make_duid dhcpv6s_duid 
           eval `utctx_cmd get dhcpv6s_duid`
        fi
        echo -n "$SYSCFG_dhcpv6s_duid" > /var/run/dhcp6s_duid
        echo "$SELF: dhcpv6 server DUID restored as $SYSCFG_dhcpv6s_duid" >> $LOG
   fi
