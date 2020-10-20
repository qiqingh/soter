   CONFIG_EMPTY=yes
   LOCAL_DHCPV6_CONF_FILE=/tmp/dhcp6s.conf$$
   rm -f $LOCAL_DHCPV6_CONF_FILE
   echo "# Automatically generated on `date` by $SELF for $EVENT" > $LOCAL_DHCPV6_CONF_FILE
   eval `get_current_lan_ipv6address`
   if [ "1" = "$SYSCFG_dhcp_server_propagate_wan_nameserver" ] ; then
      OTHER_DNS_NAMESERVERS=`sysevent get ipv6_nameserver`
      if [ -n "$CURRENT_LAN_IPV6ADDRESS" -o -n "$OTHER_DNS_NAMESERVERS" ] ; then
         echo "option domain-name-servers $CURRENT_LAN_IPV6ADDRESS $OTHER_DNS_NAMESERVERS ;" >> $LOCAL_DHCPV6_CONF_FILE
         CONFIG_EMPTY=no
      fi
   else
      if [ -n "$CURRENT_LAN_IPV6ADDRESS" ] ; then
         echo "option domain-name-servers $CURRENT_LAN_IPV6ADDRESS  ;" >> $LOCAL_DHCPV6_CONF_FILE
         CONFIG_EMPTY=no
      fi
   fi
   if [ ! -z "`sysevent get ipv6_domain`" -o ! -z "`sysevent get dhcp_domain`" ]
   then
      DOMAIN_NAMES=`sysevent get ipv6_domain`
      if [ -n "$DOMAIN_NAMES" ] ; then
         for x in $DOMAIN_NAMES ; do
            echo "option domain-name \"$x\" ;" >> $LOCAL_DHCPV6_CONF_FILE
         done
         CONFIG_EMPTY=no
      fi
      DOMAIN_NAMES=`sysevent get dhcp_domain`
      if [ -n "$DOMAIN_NAMES" ] ; then
         for x in $DOMAIN_NAMES ; do
            echo "option domain-name \"$x\" ;" >> $LOCAL_DHCPV6_CONF_FILE
         done
         CONFIG_EMPTY=no
      fi
   fi
   if [ ! -z "`sysevent get ipv6_ntp_server`" ]
   then
      echo "option ntp-servers `sysevent get ipv6_ntp_server` ;" >> $LOCAL_DHCPV6_CONF_FILE
      CONFIG_EMPTY=no
   fi
   cat $LOCAL_DHCPV6_CONF_FILE > $DHCPV6_CONF_FILE
   rm -f $LOCAL_DHCPV6_CONF_FILE
