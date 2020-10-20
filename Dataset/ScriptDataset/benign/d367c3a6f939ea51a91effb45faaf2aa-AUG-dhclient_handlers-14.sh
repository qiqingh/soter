   if [ -n "$new_dhcp6_sntp_servers" ]  ; then
      sysevent set ipv6_ntp_server "$new_dhcp6_sntp_servers"
   fi
